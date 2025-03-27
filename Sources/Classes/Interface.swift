//
//  Facade.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 24.03.25.
//
import Foundation

public extension YouTubeMusic{
    
    func search<T: Codable>(_ query: String, option: SearchType? = SearchType.none) async throws -> [T]? {
        let body = Body(query: query, params: option!.param) // finde das mit den params raus.
        let bodyData = try JSONEncoder().encode(body)
        let data = try await netService.post(url: DefaultRequest.urlSearch, body: bodyData) as Data
        let option = option ?? .song
        
        do {
            switch option {
            case .song:
                return try parseService.extractSongs(jsonData: data) as [T]
                
            case .album:
                return nil
                
            case .artist:
                return nil
                
            case .playlist:
                return try parseService.extractDefault(jsonData: data) as [T]

            case .podcasts:
                return nil
            case .none:
                return try parseService.extractDefault(jsonData: data) as [T]
            }
        } catch {
            print("Error parsing search result: \(error)")
            return nil
        }
    }
}
