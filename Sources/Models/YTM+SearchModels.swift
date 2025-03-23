//
//  YTM+SearchModels.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//

// MARK: - Structs for the search results
// any entity will be listed here
import Foundation

public extension YouTubeMusic{
    struct SearchResult<T: Decodable> {
        public let items: [T]
        public let totalResults: Int?
    }
    
    struct Song: Decodable{
        public let videoID: String
        public let artist: String
        public let title: String
        public let favorite: Bool?
        public let streamUrl: String?
    }
    // MARK: TODO structs for different search results like playlist etc
    
}
