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
    
    public func search<T: Codable>(_ query: String, option: SearchType? = nil) async throws -> [T]? {
        let body = Body(query: query, params: option!.param!) // finde das mit den params raus.
        let bodyData = try JSONEncoder().encode(body)
        let data = try await netService.post(url: DefaultRequest.urlSearch, body: bodyData) as Data
        let option = option ?? .song
        
        do {
            switch option {
            case .song:
                return try parseService.extractSongs(jsonData: data) 
                
            case .album:
                return nil
                
            case .artist:
                return nil

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
