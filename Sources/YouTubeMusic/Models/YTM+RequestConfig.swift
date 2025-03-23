//
//  YouTubeMusic+config.swift
//  httpengine
//
//  Created by Eduard Gozembiler on 23.03.25.
//

// MARK: - Request configuration
import Foundation

@available(macOS 10.15.0, *)
public extension YouTubeMusic {
    private struct Body: Codable{
        let query: String
        let context: Context
        init(
            query: String,
            clientName: String,
            clientVersion: String,
            hl: String
        ) {
            self.query = query
            self.context = Context(
                client: Client(
                    clientName: clientName,
                    clientVersion: clientVersion,
                    hl: hl),
                user: User()
            )
        }
    }
    
    private struct Context: Codable {
        let client: Client
        let user: User
        init(client: Client, user: User) {
            self.client = client
            self.user = user
        }
    }
    private struct Client: Codable{
        let clientName: String
        let clientVersion: String
        let hl: String
        init(clientName: String, clientVersion: String, hl: String) {
            self.clientName = clientName
            self.clientVersion = clientVersion
            self.hl = hl
        }
    }

    private struct User: Codable{

    }
    
    
}

