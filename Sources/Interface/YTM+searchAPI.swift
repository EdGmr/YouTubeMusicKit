//
//  YTM+search.swift
//  MusicEngine
//
//  Created by Eduard Gozembiler on 23.03.25.
//
// MARK: Interface for the search function
// it should always return an array of songes, playlist etc. user optioned
import Foundation
@available(macOS 10.15.0, *)
public extension YouTubeMusic{
    func search<T: Decodable>(query: String, option: SearchType? = nil) async throws -> SearchResult<T>? {
        
        let searchType: SearchType = option ?? .song
        let data = await Request.fetchSearchData(query: query)
        
        do {
            switch searchType {
            case .song:
                return try Parser.parseSong(data: data!) as? SearchResult<T>
            case .album:
                return try Parser.parseAlbum(data: data!) as? SearchResult<T>
            case .artist:
                return try Parser.parseArtist(data: data!) as? SearchResult<T>
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
