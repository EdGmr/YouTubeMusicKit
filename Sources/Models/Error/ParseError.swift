//
//  ParseError.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//

import Foundation

enum ParseError: Error {
    case decodeError
    case keyError(key: String)
    case castError
    case encoderError
}
