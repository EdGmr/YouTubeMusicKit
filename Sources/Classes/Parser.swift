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
    
    func extract_song<T: SearchResultType>(obj: MusicShelfRenderer, option: SearchType) throws -> [T]{
        var obj_ = obj.contents!
        let tmp = obj_.filter {($0.musicResponsiveListItemRenderer?.playlistItemData?.videoID!.count)! > 0}
        var res: [String] = obj.contents!.compactMap { item in
            let renderer = item.musicResponsiveListItemRenderer
            let playlistItemData = item.musicResponsiveListItemRenderer?.playlistItemData
            let videoID = item.musicResponsiveListItemRenderer?.playlistItemData?.videoID
            let flexColumns = item.musicResponsiveListItemRenderer?.flexColumns
            let title = item.musicResponsiveListItemRenderer?.flexColumns?[0].musicResponsiveListItemFlexColumnRenderer?.text?.runs?[0].text!
            let artist = item.musicResponsiveListItemRenderer?.flexColumns?[1].musicResponsiveListItemFlexColumnRenderer?.text?.runs?[0].text!
            return "S"
        }
        return [Song()] as! [T]
    }
    
    func extract_default<T: SearchResultType>(obj: Root, option: SearchType) throws -> [T]{
        var obj_ = obj.contents
        let tmp = obj_.filter { name in // filter only musicshelfitems
            if let name_ = name.itemSectionRenderer{
                return false
            } else if let name_ = name.musicCardShelfRenderer{
                return false
            }
            return true
        }
        let songs = tmp.filter{ item in category(name: "Songs", val: item)! }
        let artists = tmp.filter{ item in category(name: "Artists", val: item)! }


        return [Song()] as! [T]
    }
    func category(name: String, val: Contents) -> Bool? {
        return val.musicShelfRenderer?.title?.runs?[0].text?.contains(name)
    }
    
    func extract<T: SearchResultType>(jsonData: Data, with option: SearchType) throws -> [T]{
        let decoder = SearchType.song.decodeType
        let path = SearchType.song.path
        let obj_def = try parse(data: jsonData, path: SearchType.Default.path, decoder: SearchType.Default.decodeType) as! Root
        //let obj = try parse(data: jsonData, path: path, decoder: decoder) as! MusicShelfRenderer
        //return try extract_song(obj: obj, option: option)
        return try extract_default(obj: obj_def, option: .Default)
    }
    
    func parse<T: Codable>(data: Data, path: [String], decoder: T.Type) throws -> T{
        let newRoot = try navigate(jsonData: data, path: path)
        return try JSONDecoder().decode(decoder, from: newRoot)
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
}

protocol Extract{
    //associatedtype ResultItem: SearchResultType
   // var contents: [ParseObjects] { get }
    func extract<T: SearchResultType>(option: SearchType) throws -> [T]
}
extension Extract{
    func extract<T: SearchResultType>(obj: Codable, option: SearchType) throws -> [T]{
        switch option{
        case .song:
            return [Song()] as! [T]
        default:
            return [Song()] as! [T]
        }
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

