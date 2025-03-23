//
//  YTME.swift
//  MusicEngine
//
//  Created by Eduard Gozembiler on 23.03.25.
//

internal struct YTMEngine{
     let body: Body
     internal struct Body: Codable{
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
    
     internal init(
        _ clientName: String = "WEB_REMIX",
        _ version: String = "1.20250321.01.00",
        _ hl: String = "en",
        query: String
    ) {
        body = Body(query: query, clientName: clientName, clientVersion: version, hl: hl)
    }
}
