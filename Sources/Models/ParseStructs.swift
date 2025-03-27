//
//  ParseStructs.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//

struct NavPaths{
    static let forSongs = [
        "contents",
        "tabbedSearchResultsRenderer",
        "tabs",
        "0",
        "tabRenderer",
        "content",
        "sectionListRenderer",
        "contents",
        "1",
        "musicShelfRenderer",
    ]
    static let forDefault = [
        "contents",
        "tabbedSearchResultsRenderer",
        "tabs",
        "0",
        "tabRenderer",
        "content",
        "sectionListRenderer",
        ]
}
enum searchOption{
    case defaultOption
    case song
}
extension searchOption{
    var path: [String] {
        switch self{
        case .defaultOption:
            return NavPaths.forDefault
        case .song:
            return NavPaths.forSongs
        }
    }
}
enum ParseType{
    case song
    case playlist
}

extension ParseType{
    var param: String?{
        switch self{
        case .song:
            return "EgWKAQIIAWoMEA4QChADEAQQCRAF"
        case .playlist:
            return "Eg-KAQwIABAAGAAgACgBMABqChAEEAMQCRAFEAo%3D"
        }
    }
}
