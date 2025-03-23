//
//  YTM+request.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
import Foundation
extension YouTubeMusic{
    struct Request: Sendable {
        let body: Request.Body?
        let method: String
        let url: URL
        let headers: [String: String]
        init(
            body: Request.Body?,
            method: String,
            url: URL,
            headers: [String: String]
        ) throws {
            self.body = body
            self.method = method
            self.url = url
            self.headers = headers
        }
    }
}


private extension YouTubeMusic.Request{
     func encodedBody() throws -> Data?{
        guard let body = self.body else { return nil }
         return try JSONEncoder().encode(body)
        
    }
    
     func fetch(from request: URLRequest) async throws -> Data{
        let (data, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299: // Success codes (2xx)
                return data // Proceed with the data
            
            case 400...499: // Client error codes (4xx)
                throw URLError(.badURL) // Handle specific client errors here
            
            case 500...599: // Server error codes (5xx)
                throw URLError(.cannotConnectToHost) // Handle server errors here
                
            default:
                throw URLError(.unknown) // Handle unexpected status codes
            }
        }
        
        // If the response is not an HTTPURLResponse
        throw URLError(.unknown)
    }
    
     func prepareRequest() throws -> URLRequest{
        var request = URLRequest(url: self.url)
        for (key, value) in self.headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpMethod = self.method
        if self.method.uppercased() == "POST"{
            request.httpBody = try self.encodedBody() // Encode body if it's a POST request
        }
        return request
    }
}

// MARK: - static fetches for the different requests

extension YouTubeMusic.Request{
    static func fetchSearchData(query: String) async -> Data? {
        let body = YouTubeMusic.Request.Body(query: query)
        do{
            let request = try YouTubeMusic.Request(body: body,
                                                   method: "POST",
                                                   url: YouTubeMusic.Request.DefaultParam.urlSearch,
                                                   headers: YouTubeMusic.Request.DefaultParam.headers
            )
            let requestPayload = try request.prepareRequest()
            return try await request.fetch(from: requestPayload)
        } catch {
            print("Error in fetchSearchData(): \(error)")
        }
        return nil
    }
}



