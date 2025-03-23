//
//  YTM+parse.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
import Swift
import Foundation
extension YouTubeMusic {
    enum Parser{
        static let songPath = [
            "contents",
            "tabbedSearchResultsRenderer",
            "tabs",
            "0",
            "tabRenderer",
            "content",
            "sectionListRenderer",
            "contents"]
    }/*
    let title = item.musicResponsiveListItemRenderer?.flexColumns![0].musicResponsiveListItemFlexColumnRenderer!.text!.runs![0].text
    let author = item.musicResponsiveListItemRenderer?.flexColumns![1].musicResponsiveListItemFlexColumnRenderer!.text!.runs![0].text
    let vID = item.musicResponsiveListItemRenderer?.playlistItemData?.videoID
    static musicResponsiveListItemRenderer?.playlistItemData?.videoID*/
}

extension YouTubeMusic.Parser{
    static func decode(){
        
    }
}
// MARK: - Static FUNCS
extension YouTubeMusic.Parser{
    static func navigate<T>(jsonData: Data, path: [String]) throws -> T {
        guard let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
            throw ParseError.decodeError
        }
        
        var current: Any = json
        
        //navigate through each key in the path
        for key in path {
            //TODO: handle dictionary access when Dicit index is "0" as a string and not an array index
            if let arrayIndex = Int(key), let array = current as? [Any], arrayIndex < array.count {
                // Handle array indexing when key is a number
                current = array[arrayIndex]
            } else if let dict = current as? [String: Any], let value = dict[key] {
                // Handle dictionary access
                current = value
            } else {
                throw ParseError.keyError(key: key)
            }
        }
        // Try to cast to expected return type
        guard let result = current as? T else {
            throw ParseError.castError
        }
        
        return result
    }
    
    static func extractData(jsonData: Data, path: [String]) throws -> Data? {
        do{
            let result: [String: Any]  = try navigate(jsonData: jsonData, path: path)
            return try JSONSerialization.data(withJSONObject: result)
        } catch {
            print("error extracting data: \(error)")
        }
        return nil
    }
}

// MARK: - Parsing funcs for the different options
extension YouTubeMusic.Parser{
    static func parseSong(data: Data) throws-> SearchResult<Song>{
        let dummy_res = SearchResult(items: [Song(videoID: "", artist: "", title: "")], totalResults: 1)
        return dummy_res
    }
    static func parseAlbum(data: Data) throws -> SearchResult<Song>{
        let dummy_res = SearchResult(items: [Song(videoID: "", artist: "", title: "")], totalResults: 1)
        return dummy_res
    }
    static func parseArtist(data: Data) throws -> SearchResult<Song>{
        let dummy_res = SearchResult(items: [Song(videoID: "", artist: "", title: "")], totalResults: 1)
        return dummy_res
    }
}
