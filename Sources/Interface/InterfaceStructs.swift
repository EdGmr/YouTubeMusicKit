//
//  InterfaceStructs.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//

public enum SearchType{
    case song
    case playlist
    case artist
    case album
    case podcasts
}
internal extension SearchType{
    var param: String?{
        switch self{
        case .song:
            return "EgWKAQIIAWoMEA4QChADEAQQCRAF"
        case .playlist:
            return nil

        case .artist:
            return nil
        case .album:
            return nil
        case .podcasts:
            return nil
        }
    }
}
