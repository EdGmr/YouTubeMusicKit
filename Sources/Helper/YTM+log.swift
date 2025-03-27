//
//  YTM+log.swift
//  YouTubeMusicKit
//
//  Created by Eduard Gozembiler on 23.03.25.
//
import Foundation

@available(macOS 14.0, *)
public extension YouTubeMusic {
     struct timer{
        var clock: ContinuousClock
        var startTime: ContinuousClock.Instant?
        var endTime: ContinuousClock.Instant?
        public init() {
            self.clock = ContinuousClock()
        }
    }
    struct log{
        
    }
}

@available(macOS 14.0, *)
public extension YouTubeMusic.timer {
    mutating func startTimer(){
        self.startTime = clock.now
    }
    
    func logTime()
    {
        let duration = clock.now - startTime!
        print("Time taken = \(duration)")
    }
}

@available(macOS 14.0, *)
public extension YouTubeMusic.log{
    func printSongs(songs: [Song]){
        var i = 1
        for song in songs{
            print("search result: \(i)")
            print(" author: \(song.artist)\n title: \(song.title)")
            print(" https://www.youtube.com/watch?v=\(song.videoId)\n")
            i+=1
        }
    }
    
    static func logData(_ date: Data, name: String, query: String?=nil) {
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

