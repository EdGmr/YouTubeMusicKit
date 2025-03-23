//
//  Parser.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//

import Foundation

class ParseService{
    let dummy_res = SearchResult(items: [Song(videoID: "", artist: "", title: "")], totalResults: 1)
    // Specialized convenience methods
    func parse<T: Decodable>(jsonData: Data, option: ParseOption, searchType: SearchType) throws -> SearchResult<T> {
        let newRoot: [Any] = try navigate(jsonData: jsonData, path: option.path)
        let newData = try JSONSerialization.data(withJSONObject: newRoot)
        let contents = try JSONDecoder().decode(Root.self, from: newData)
        let Songs = contents[1].musicShelfRenderer!.contents
        var songResult = [Song(videoID: "", artist: "", title: "")]
        for item in Songs!{
            let song = Song(videoID: item.musicResponsiveListItemRenderer!.playlistItemData!.videoID!,
                            artist: item.musicResponsiveListItemRenderer!.flexColumns![1].musicResponsiveListItemFlexColumnRenderer!.text!.runs![0].text!,
                            title: item.musicResponsiveListItemRenderer!.flexColumns![1].musicResponsiveListItemFlexColumnRenderer!.text!.runs![0].text!
                            )
            songResult.append(song)
        }
        let res = SearchResult(items: songResult, totalResults: songResult.count)
        return res as! SearchResult<T>
    }
    private func extractResults<T: Decodable>(jsonData: Data, searchType: SearchType) throws -> SearchResult<T>{
        if searchType == .song {
            
        }
        return dummy_res as! SearchResult<T>
    }
   //helper functions
    private func navigate<T>(jsonData: Data, path: [String]) throws -> [T] {
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
        guard let result = current as? [T] else {
            throw ParseError.typeError
        }
        return result
    }
}


