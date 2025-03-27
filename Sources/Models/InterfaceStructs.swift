//
//  InterfaceStructs.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
public struct SearchResult<T>{
    public let result: [T]
}
public struct Song: Codable{
    public let videoID: String
    public let artist: String
    public let title: String
}

public struct PlayList: Codable{
    public let id: String
}
// MARK: TODO structs for different search results like playlist etc

public enum SearchType{
    case song
    case playlist
    case artist
    case album
    case podcasts
    case none
}
internal extension SearchType{
    var param: String?{
        switch self{
        case .song:
            return "EgWKAQIIAWoMEA4QChADEAQQCRAF"
        case .playlist:
            return "Eg-KAQwIABAAGAAgACgBMABqChAEEAMQCRAFEAo%3D"

        case .artist:
            return nil
        case .album:
            return nil
        case .podcasts:
            return nil
        case .none:
            return nil
        }
    }
}
