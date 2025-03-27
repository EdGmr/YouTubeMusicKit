//
//  Parser.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//

import Foundation

class Parser{
    //TODO: id und so mit ner find funktion finden und die key:value paare dann dynamisch setzen
    //das hartgedotete muss raus

    // convinience func
    func extractSongs<T: Codable>(jsonData: Data) throws -> [T]{
        let content = try jsonDecoder(jsonData: jsonData, ofType: MusicShelfRenderer.self, option: .song)
        let Songs = content.contents!
        var songResult = [Song(videoID: "", artist: "", title: "")]
        for item in Songs{
            let song = Song(videoID: item.musicResponsiveListItemRenderer!.playlistItemData!.videoID!,
                            artist: item.musicResponsiveListItemRenderer!.flexColumns![1].musicResponsiveListItemFlexColumnRenderer!.text!.runs![0].text!,
                            title: item.musicResponsiveListItemRenderer!.flexColumns![0].musicResponsiveListItemFlexColumnRenderer!.text!.runs![0].text!
            )
            songResult.append(song)
        }
        return songResult as! [T]
    }
    func extractDefault<T: Codable>(jsonData: Data) throws -> [T]{
        let content: Any = try navigate(jsonData: jsonData, path: searchOption.defaultOption.path)
        let newData = try JSONSerialization.data(withJSONObject: content)
        let res = ["hallo", "tschus"]
        return res as! [T]
    }
    

    private func jsonDecoder<T: Decodable>(jsonData: Data, ofType: T.Type, option: searchOption) throws -> T {
        let newRoot: Any = try navigate(jsonData: jsonData, path: option.path)
        let newData = try JSONSerialization.data(withJSONObject: newRoot)
        return try JSONDecoder().decode(T.self, from: newData)
    }
   //helper functions
    private func navigate<T>(jsonData: Data, path: [String]) throws -> T {
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
            throw ParseError.typeError
        }
        return result
    }
}


