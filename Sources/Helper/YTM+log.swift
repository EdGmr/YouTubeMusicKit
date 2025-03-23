//
//  YTM+log.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
import Foundation

public extension YouTubeMusic {
    func printSongs(songs: [Song]){
        var i = 1
        for song in songs{
            print("search result: \(i)")
            print(" author: \(song.artist)\n title: \(song.title)")
            print(" https://www.youtube.com/watch?v=\(song.videoID)\n")
            i+=1
        }
    }
    
    func logData(_ date: Data, name: String, query: String?=nil) {
        do {
            var nameToLog: String
            if let query_ = query{
                nameToLog = name+query_
            } else {
                nameToLog = name
            }
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent("\(nameToLog).json")
            try date.write(to: fileURL)
            print("logged: at \(nameToLog)")

        } catch {
            print("Error saving JSON: \(error)")
        }
    }
}

