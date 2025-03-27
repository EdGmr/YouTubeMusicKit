//
//  Facade.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 24.03.25.
//
import Foundation

public extension YouTubeMusic{
    
    public func search<T: SearchResultType>(_ query: String, option: SearchType? = .Default) async throws -> [T]? {
        let searchType = option ?? .Default
        let payload = try JSONEncoder().encode(Body(query: query, params: searchType.param))
        let data = try await self.networkService.post(url: DefaultRequest.urlSearch, payload: payload)
        do {
            return try self.parser.extract(
                jsonData: data,
                with: searchType
            )
        } catch {
            print("Error parsing search result: \(error)")
            return nil
        }
    }
}
