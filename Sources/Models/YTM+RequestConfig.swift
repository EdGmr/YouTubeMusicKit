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
        let query: String?
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
}

extension YouTubeMusic{
    struct DefaultParam{
        let clientName: String
        let version: String
        let hl: String
        init(
            clientName: String = "WEB_REMIX",
            version: String = "1.20250321.01.00",
            hl: String = "en"
        ){
           self.clientName = clientName
           self.version = version
           self.hl = hl
       }
    }
}
