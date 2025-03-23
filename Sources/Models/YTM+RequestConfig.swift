//
//  YouTubeMusic+config.swift
//  httpengine
//
//  Created by Eduard Gozembiler on 23.03.25.
//

// MARK: - Request configuration
import Foundation

@available(macOS 10.15.0, *)
extension YouTubeMusic {
    struct Body: Codable{
        var query: String?
        let context: Context
        init(
            query: String? = nil,
            clientName: String,
            clientVersion: String,
            hl: String
        ) {
            self.query = query ?? nil
            self.context = Context(
                client: Client(
                    clientName: clientName,
                    clientVersion: clientVersion,
                    hl: hl),
                user: User()
            )
        }
        init(query: String){
            self.init(query: query, clientName: DefaultParam.clientName, clientVersion: DefaultParam.version, hl: DefaultParam.hl)
        }
    }
    
    struct Context: Codable {
        let client: Client
        let user: User
        init(client: Client, user: User) {
            self.client = client
            self.user = user
        }
    }
    struct Client: Codable{
        let clientName: String
        let clientVersion: String
        let hl: String
        init(clientName: String, clientVersion: String, hl: String) {
            self.clientName = clientName
            self.clientVersion = clientVersion
            self.hl = hl
        }
    }
    
    struct User: Codable{
        
    }
    enum Method: String{
        case POST = "POST"
        case GET = "GET"
    }
}

extension YouTubeMusic {
     struct DefaultParam {
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
 }
