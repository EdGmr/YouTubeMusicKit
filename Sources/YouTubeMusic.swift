// The Swift Programming Language
// https://docs.swift.org/swift-book
//
//  YouTubeMusic.swift
//  httpengine
//
//  Created by Eduard Gozembiler on 23.03.25.
//

import Foundation
@preconcurrency import os.log
@MainActor
public final class YouTubeMusic { // basically a facade
    let netService: NetworkService
    let parseService: Parser
    public init(){
        netService = NetworkService()
        parseService = Parser()
    }
}
