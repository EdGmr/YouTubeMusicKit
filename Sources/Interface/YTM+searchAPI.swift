//
//  YTM+search.swift
//  MusicEngine
//
//  Created by Eduard Gozembiler on 23.03.25.
//
// MARK: Interface for the search function
// it should always return an array of songes, playlist etc. user optioned

@available(macOS 10.15.0, *)
public extension YouTubeMusic{
    func search<T: Decodable>(query: String, option: SearchType? = nil) async throws -> SearchResult<T>? {
        
        let searchType: SearchType = option ?? .song
        
        switch searchType{
        case .song:
            return nil
        case .album:
            return nil
        case .artist:
            return nil
        case .playlist:
            return nil
        case .podcasts:
            return nil
        }
    }
}
