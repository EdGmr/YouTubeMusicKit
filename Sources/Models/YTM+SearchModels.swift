//
//  YTM+SearchModels.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//

// MARK: - Structs for the search results
// any entity will be listed here
import Foundation


public struct Song: Codable{
    public let videoID: String
    public let artist: String
    public let title: String
}

public struct PlayList: Codable{
    public let id: String
}
// MARK: TODO structs for different search results like playlist etc

