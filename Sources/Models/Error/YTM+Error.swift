//
//  YTM+Error.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//

public extension YouTubeMusic{
    enum Error: Swift.Error{
        case notFound
        case encode
        case responseCast
        case invalidBody
        case invalidURL
        case parsingError(String)
    }
}
