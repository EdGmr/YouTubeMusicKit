// The Swift Programming Language
// https://docs.swift.org/swift-book
//
//  YouTubeMusic.swift
//  httpengine
//
//  Created by Eduard Gozembiler on 23.03.25.
//

import Foundation
@preconcurrency import os.log
@MainActor
public final class YouTubeMusic { // basically a facade
    let netService: NetworkService
    
    public init(){
        netService = NetworkService()
    }
    
    public func search<T: Codable>(_ query: String, option: SearchType? = nil) async throws -> SearchResult<T>? {
        let body = Body(query: query)
        let bodyData = try JSONEncoder().encode(body)
        let data = try await netService.post(url: DefaultRequest.urlSearch, body: bodyData) as Data
        let option = option ?? .song
        
        do {
            switch option {
            case .song:
                return try Parser.parseSong(data: data) as? SearchResult<T>
                
            case .album:
                return try Parser.parseAlbum(data: data) as? SearchResult<T>
                
            case .artist:
                return try Parser.parseArtist(data: data) as? SearchResult<T>
                
            case .playlist:
                return nil
                
            case .podcasts:
                return nil
            }
        } catch {
            print("Error parsing search result: \(error)")
            return nil
        }
    }
}
