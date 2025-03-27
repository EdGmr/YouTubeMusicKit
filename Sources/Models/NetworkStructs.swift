//
//  Request.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
import Foundation

    enum HTTPMethod: String{
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    struct DefaultRequest{
        static let clientName = "WEB_REMIX"
        static let version = "1.20250321.01.00"
        static let hl = "en"
        static let urlSearch = URL(string: "https://music.youtube.com/youtubei/v1/search")!
        static let headers: [String: String] = [
            "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0",
            "accept": "*//*",
            "accept-encoding": "gzip, deflate",
            "content-type": "application/json",
            "content-encoding": "gzip",
            "origin": "https://music.youtube.com",
            "X-Goog-Visitor-Id": "CgtsSDNmbmF3OE5JSSiHwva-BjIKCgJERRIEEgAgPg%3D%3D"
        ]
    }
    
    struct Body: Codable {
        var query: String?
        var params: String?   //TODO: Figure out params
        let context: Context
        
        // Main initializer with defaults
        init(
            query: String? = nil,
            params: String? = nil,
            clientName: String = DefaultRequest.clientName,
            clientVersion: String = DefaultRequest.version,
            hl: String = DefaultRequest.hl
        ) {
            self.query = query
            self.params = params
            self.context = Context(
                client: Client(
                    clientName: clientName,
                    clientVersion: clientVersion,
                    hl: hl
                ),
                user: User()
            )
        }
    }
    
    struct Context: Codable {
        let client: Client
        let user: User
    }
    
    struct Client: Codable {
        let clientName: String
        let clientVersion: String
        let hl: String
    }
    
    struct User: Codable {
        
    }
    

