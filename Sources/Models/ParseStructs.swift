//
//  ParseStructs.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//

struct NavPaths{
    static let forSearchResults = [
        "contents",
        "tabbedSearchResultsRenderer",
        "tabs",
        "0",
        "tabRenderer",
        "content",
        "sectionListRenderer",
        "contents"]
}
enum ParseOption{
    case search 
    case placeHolder
}
extension ParseOption{
    var path: [String] {
        switch self{
        case .search:
            return NavPaths.forSearchResults
        case .placeHolder:
            return [""]
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
            return nil
        }
    }
}
