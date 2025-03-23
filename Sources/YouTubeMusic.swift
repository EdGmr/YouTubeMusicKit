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
    let parseService: ParseService
    public init(){
        netService = NetworkService()
        parseService = ParseService()
    }
    
    public func search<T: Codable>(_ query: String, option: SearchType? = nil) async throws -> SearchResult<T>? {
        let body = Body(query: query, params:"EgWKAQIIAWoMEA4QChADEAQQCRAF")
        let bodyData = try JSONEncoder().encode(body)
        let data = try await netService.post(url: DefaultRequest.urlSearch, body: bodyData) as Data
        let option = option ?? .song
        
        do {
            switch option {
            case .song:
                return try parseService.parse(jsonData: data, option: .search, searchType: .song) as SearchResult<T>
                
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
