//
//  Parser.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//

import Foundation


final class Parser: Sendable{
    //TODO: id und so mit ner find funktion finden und die key:value paare dann dynamisch setzen
    //das hartgedotete muss raus
    
    func extractMap<T: SearchResultType>(item: MusicShelfRendererContent, option: SearchType) -> T{
        var views: String?
        var duration: String?
        let renderer = item.musicResponsiveListItemRenderer
        let playlistItemData = item.musicResponsiveListItemRenderer?.playlistItemData
        let videoID = item.musicResponsiveListItemRenderer?.playlistItemData?.videoID
        let title = item.musicResponsiveListItemRenderer?.flexColumns?[0].musicResponsiveListItemFlexColumnRenderer?.text?.runs?[0].text!
        let artist = item.musicResponsiveListItemRenderer?.flexColumns?[1].musicResponsiveListItemFlexColumnRenderer?.text?.runs?[0].text!
        let name = item.musicResponsiveListItemRenderer?.flexColumns?[0].musicResponsiveListItemFlexColumnRenderer?.text?.runs?[0].text!
        let browseId = item.musicResponsiveListItemRenderer?.navigationEndpoint?.browseEndpoint?.browseID
        
        if option == .video{
            duration = (item.musicResponsiveListItemRenderer?.flexColumns?[1].musicResponsiveListItemFlexColumnRenderer?.text?.runs?[6].text)!
            views = (item.musicResponsiveListItemRenderer?.flexColumns?[1].musicResponsiveListItemFlexColumnRenderer?.text?.runs?[4].text)!
        } else {
            duration = nil
            views = nil
        }
        switch option{
        case .song:
            return Song(videoId: videoID, artist: artist, title: title, album: name, duration: duration, duration_seconds: nil, is_explicit: nil) as! T
        case .video:
            return Video(videoId: videoID!, title: title!, artist: artist!, views: views!, duration: duration!, duration_seconds: nil) as! T
        default:
            return Song(videoId: videoID, artist: artist, title: title, album: name, duration: duration, duration_seconds: nil, is_explicit: nil) as! T
        }
    }
    
    func extractInfo<T: SearchResultType>(obj: MusicShelfRenderer, option: SearchType) -> [T]{
        var contents = obj.contents!
        return obj.contents!.compactMap { item in extractMap(item: item, option: option) as T }
    }
    
    //func getSongs(contents: Contents, )
    func extract<T: SearchResultType>(jsonData: Data, with option: SearchType) throws -> [T]{
        let newRoot = try navigate(jsonData: jsonData, path: option.path)
        let decoder = option.decodeType
        let obj = try JSONDecoder().decode(decoder, from: navigate(jsonData: jsonData, path: option.path))
        return try extractInfo(obj: obj as! MusicShelfRenderer, option: option) as [T]
    }
    
    func navigate(jsonData: Data, path: [String]) throws -> Data {
        // First, parse the entire JSON
        let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
        let result = try navigateRecursive(from: json, path: path)
        return try JSONSerialization.data(withJSONObject: result)
    }
    
    private func navigateRecursive(from json: Any, path: [String]) throws -> Any {
        guard !path.isEmpty else {
            return json
        }
        
        let key = path[0]
        let remainingPath = Array(path.dropFirst())
        
        switch json {
        case let dict as [String: Any]:
            guard let value = dict[key] else {
                throw ParseError.pathNotFound(path: path)
            }
            return try navigateRecursive(from: value, path: remainingPath)
            
        case let array as [Any]:
            // Handle numeric string index for arrays
            if let index = Int(key), index >= 0 && index < array.count {
                return try navigateRecursive(from: array[index], path: remainingPath)
            }
            throw ParseError.pathNotFound(path: path)
            
        default:
            // If we've reached the end of the path, return the current value
            guard remainingPath.isEmpty else {
                throw ParseError.pathNotFound(path: path)
            }
            return json
        }
    }
    func extractSearchResults<T: SearchResultType>(
        jsonData: Data,
        option: SearchType
    ) throws -> [T] {
        let decoder = JSONDecoder()
        let root = try decoder.decode(Root.self, from: navigate(jsonData: jsonData, path: SearchType.Default.path))
        
        guard let renderer = root.contents[1].musicShelfRenderer else {
            return []
        }

        return renderer.decodeContents(option: option)
    }
}
extension MusicShelfRendererContent {
        func decode<T: SearchResultType>(option: SearchType) -> T? {
            guard let renderer = musicResponsiveListItemRenderer else { return nil }
            
            // Create a dictionary of values that can be used for decoding
            var jsonDict: [String: Any?] = [
                "videoId": renderer.playlistItemData?.videoID,
                "title": renderer.flexColumns?[0]
                    .musicResponsiveListItemFlexColumnRenderer?
                    .text?.runs?[0].text,
                "artist": renderer.flexColumns?[1]
                    .musicResponsiveListItemFlexColumnRenderer?
                    .text?.runs?[0].text
            ]
            
            // Add additional details based on search type
            if option == .video {
                jsonDict["views"] = renderer.flexColumns?[1]
                    .musicResponsiveListItemFlexColumnRenderer?
                    .text?.runs?[4].text
                jsonDict["duration"] = renderer.flexColumns?[1]
                    .musicResponsiveListItemFlexColumnRenderer?
                    .text?.runs?[6].text
            }
            
            // Convert to JSON data for decoding
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonDict.compactMapValues { $0 })
                return try JSONDecoder().decode(T.self, from: jsonData)
            } catch {
                print("Decoding error: \(error)")
                return nil
            }
        }
    }

extension MusicShelfRenderer {
        // Decode an array of search results
        func decodeContents<T: SearchResultType>(option: SearchType) -> [T] {
            return contents?
                .compactMap { $0.decode(option: option) } ?? []
        }
    }

extension SearchType{
    var path: [String] {
        switch self{
        case .song, .album, .artist, .playlist, .podcast, .video:
            return NavPath.forSongs
        default:
            return NavPath.forDefault
        }
    }
    
    
    var decodeType: Codable.Type {
        switch self{
        case .song, .album, .artist, .playlist, .podcast, .video:
            return MusicShelfRenderer.self
        default:
            return Root.self
        }
    }
    
    
}

enum NavPath{
    static let forSongs = [
        "contents",
        "tabbedSearchResultsRenderer",
        "tabs",
        "0",
        "tabRenderer",
        "content",
        "sectionListRenderer",
        "contents",
        "1",
        "musicShelfRenderer",
    ]
    static let forDefault = [
        "contents",
        "tabbedSearchResultsRenderer",
        "tabs",
        "0",
        "tabRenderer",
        "content",
        "sectionListRenderer",
        ]
    
}

