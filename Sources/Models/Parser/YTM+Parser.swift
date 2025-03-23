//
//  YTM+parse.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
import Foundation
extension YouTubeMusic {
    struct Parser{
        
    }
}

extension YouTubeMusic.Parser{
    func setRoot(_ date: Data) -> Data? {
        let json = try? JSONSerialization.jsonObject(
            with: date,
            options: .allowFragments
        )
        let root = json as? [String: Any]
        let contents = root!["contents"] as? [String: Any]
        let tabbed = contents!["tabbedSearchResultsRenderer"] as? [String: Any]
        let tabs = tabbed!["tabs"] as? [[String: Any]]
        let tabD = tabs![0]
        let tabR = tabD["tabRenderer"] as? [String: Any]
        let content = tabR!["content"] as? [String: Any]
        let sec = content!["sectionListRenderer"] as? [String: Any]
        let res = sec!["contents"]
        guard
            let data = try? JSONSerialization.data(withJSONObject: res!)
        else{
            return nil
        }
        return data
    }
    
    func decode(){
        
    }
}
// MARK: - Static FUNCS
extension YouTubeMusic.Parser{
    static func navigate<T>(jsonData: Data, path: [String]) throws -> T {
        guard let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
            throw YouTubeMusic.Error.parsingError("Failed to parse initial JSON")
        }
        
        var current: Any = json
        
        //navigate through each key in the path
        for key in path {
            //TODO: handle dictionary access when Dict index is "0" as a string and not an array index
            if let arrayIndex = Int(key), let array = current as? [Any], arrayIndex < array.count {
                // Handle array indexing when key is a number
                current = array[arrayIndex]
            } else if let dict = current as? [String: Any], let value = dict[key] {
                // Handle dictionary access
                current = value
            } else {
                throw YouTubeMusic.Error.parsingError("Unable to navigate to key: \(key)")
            }
        }
        // Try to cast to expected return type
        guard let result = current as? T else {
            throw YouTubeMusic.Error.parsingError("Type mismatch: Expected \(T.self), but got \(type(of: current))")
        }
        
        return result
    }
    
    static func extractData(jsonData: Data, path: [String]) throws -> Data? {
        do{
            let result: [String: Any]  = try navigate(jsonData: jsonData, path: path)
            return try JSONSerialization.data(withJSONObject: result)
        } catch YouTubeMusic.Error.parsingError{
            print("error navigatin JSON: \(String(describing: YouTubeMusic.Error.parsingError))")
        } catch {
            print("error extracting data: \(error)")
        }
        return nil
    }
}

// MARK: - Parsing funcs for the different options
extension YouTubeMusic.Parser{
    static func parseSong(data: Data) throws-> YouTubeMusic.SearchResult<YouTubeMusic.Song>{
        let dummy_res = YouTubeMusic.SearchResult(items: [YouTubeMusic.Song(videoID: "", artist: "", title: "", favorite: false, streamUrl: "")], totalResults: 1)
        return dummy_res
    }
    static func parseAlbum(data: Data) throws -> YouTubeMusic.SearchResult<YouTubeMusic.Song>{
        let dummy_res = YouTubeMusic.SearchResult(items: [YouTubeMusic.Song(videoID: "", artist: "", title: "", favorite: false, streamUrl: "")], totalResults: 1)
        return dummy_res
    }
    static func parseArtist(data: Data) throws -> YouTubeMusic.SearchResult<YouTubeMusic.Song>{
        let dummy_res = YouTubeMusic.SearchResult(items: [YouTubeMusic.Song(videoID: "", artist: "", title: "", favorite: false, streamUrl: "")], totalResults: 1)
        return dummy_res
    }
}
