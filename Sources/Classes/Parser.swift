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
        return try extract_default(obj: obj as! Root, option: option) as [T]
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
    func extract_default<T: SearchResultType>(obj: Root, option: SearchType) throws -> [T]{
        var store = [T]()
        var obj_ = obj.contents
        let tmp = obj_.filter { name in // filter only musicshelfitems
            if let name_ = name.itemSectionRenderer{
                return false
            } else if let name_ = name.musicCardShelfRenderer{
                return false
            }
            return true
        }
        
        try SearchType.allCases.forEach{ c in
            let objFiltered = try tmp.filter{ ($0.musicShelfRenderer?.title?.runs?[0].text?.contains(c.rawValue))!}
            if !objFiltered.isEmpty {
                let tmpr = extractInfo(obj: objFiltered[0].musicShelfRenderer!, option: c) as [T]
                store.append(contentsOf: tmpr)
            }
        }
        return store
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

