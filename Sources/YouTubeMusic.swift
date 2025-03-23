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
public final class YouTubeMusic: Observable {
    let testI: Int
    private let private_test: Bool
    nonisolated public init(testI: Int) {
        self.testI = testI
        self.private_test = true
    }
}
