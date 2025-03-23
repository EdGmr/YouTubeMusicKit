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
    func setRoot(){
        
    }
    
    func decode(){
        
    }
}

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
