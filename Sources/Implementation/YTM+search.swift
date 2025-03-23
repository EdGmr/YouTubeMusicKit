//
//  YTM+search.swift
//  MusicEngine
//
//  Created by Eduard Gozembiler on 23.03.25.
//
import Foundation
extension YouTubeMusic {
    
    func searchSong(query: String) async -> Data? {
        let body = Body(query: query)
        
        do{
            let request = try YouTubeMusic.Request(body: body, method: "POST", url: DefaultParam.urlSearch, headers: DefaultParam.headers)
            let requestPayload = try request.prepareRequest()
            return try await request.fetch(from: requestPayload)
        } catch YouTubeMusic.Error.invalidBody {
            print("Invalid body in searchSong()")
        } catch YouTubeMusic.Error.invalidURL {
            print("Invalid URL in searchSong()")
        } catch {
            print("Error in searchSong(): \(error)")
        }
        return nil
        
    }
}


