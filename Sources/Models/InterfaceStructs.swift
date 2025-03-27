//
//  InterfaceStructs.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
public protocol SearchResultType: Codable, Sendable {}
/*public struct Default: SearchResultType{
    public let songs: [Song]? //2
    public let albums: [Album]? //4
    public let playlists: [Playlist]? //5
    public let artists: [Artist]? //6
    public let podcasts: [Podcast]? //8-9
    init(songs: [Song]?=nil, albums: [Album]?=nil, playlists: [Playlist]?=nil, artists: [Artist]?=nil, podcasts: [Podcast]?=nil) {
        self.songs = songs
        self.albums = albums
        self.playlists = playlists
        self.artists = artists
        self.podcasts = podcasts
    }
}*/

public struct def: SearchResultType {
    public var songStruct: Song?
    public var podcastStruct: Podcast?
    public var albumStruct: Album?
    public var videoStruct: Video?
    public var artistStruct: Artist?
    
    public var videoID: String?
    public var artist: String?
    public var title: String?
    public var album: String?
    public var duration: String?
    public var duration_seconds: Int?
    public var is_explicit: Bool?
    public var browseId: String?
    public var name: String?
    public var shuffleId: String?
    public var radioId: String?
    public var views: String?
    
}

public struct Song: SearchResultType{
    public let videoId: String?
    public let artist: String?
    public let title: String?
    public let album: String?
    public let duration: String?
    public let duration_seconds: Int?
    public let is_explicit: Bool?
    
}

public struct Playlist: SearchResultType{
    public let id: String
    public let title: String
}
// MARK: TODO structs for different search results like playlist etc
public struct Podcast: SearchResultType{
    public let name: String
    public let title: String
}

public struct Album: SearchResultType{
    public let browseId: String
    public let title: String
    public let playlistID: String
    public let artist: String
    public let year: String
}

public struct Artist: SearchResultType{
    public let browseId: String?
    public let name: String?
    public let shuffleId: String?
    public let radioId: String?
}

public struct Video: SearchResultType{
    public let videoId: String
    public let title: String
    public let artist: String
    public let views: String
    public let duration: String
    public let duration_seconds: String?
}

public enum SearchType: String, Sendable, CaseIterable{
    case song = "Songs"
    case album = "Albums"
    case artist = "Artists"
    case playlist = "Playlists"
    case podcast = "Podcasts"
    case video = "Videos"
    case Default = "default"
    
    // Type-safe mapping to result types
    func resultType() -> SearchResultType.Type {
        switch self {
        case .video: return Video.self
        case .song: return Song.self
        case .album: return Album.self
        case .artist: return Artist.self
        case .playlist: return Playlist.self
        case .podcast: return Podcast.self
        default: return def.self
        }
    }
}

internal extension SearchType{
    var param: String?{
        switch self{
        case .video:
            return nil
        case .song:
            return "EgWKAQIIAWoMEA4QChADEAQQCRAF"
        case .playlist:
            return "Eg-KAQwIABAAGAAgACgBMABqChAEEAMQCRAFEAo%3D"

        case .artist:
            return nil
        case .album:
            return nil
        case .podcast:
            return nil
        default:
            return nil
        }
    }
}
