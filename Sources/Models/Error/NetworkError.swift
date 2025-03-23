//
//  YTM+Error.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
import Foundation

enum NetworkError: Error {
    case invalidResponse
    case clientError(statusCode: Int, data: Data)
    case serverError(statusCode: Int)
    case unexpectedStatusCode(Int)
    case bodyNotAllowedForMethod(HTTPMethod)
    case unexpectedResponseType
}
