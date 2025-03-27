// The Swift Programming Language
// https://docs.swift.org/swift-book
//
//  YouTubeMusic.swift
//  httpengine
//
//  Created by Eduard Gozembiler on 23.03.25.
//

import Foundation
//@preconcurrency import os.log
public final class YouTubeMusic: Sendable{ // basically a facade
     let networkService: NetworkService
     let parser: Parser
    public init(){
        self.networkService = NetworkService()
        self.parser = Parser()
    }
}
