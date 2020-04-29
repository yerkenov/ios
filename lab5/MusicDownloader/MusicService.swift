//
//  MusicService.swift
//  MusicDownloader
//
//  Created by Almukhammed Yerkenov on 4/26/20.
//  Copyright © 2020 Almukhammed Yerkenov. All rights reserved.
//

import Foundation
import AVFoundation

class MusicService {
   
    static let shared = MusicService()
    var player: AVPlayer?
    

    func searchForMusic(completion: @escaping (MusicSearchResponse?, Error?) -> ()) {
        let url = URL(string: "https://itunes.apple.com/search?term=eminem&entity=song")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MusicSearchResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(response, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    
    func play(track: Track) {
        let playerItem: AVPlayerItem
        
        switch isDownloaded(track: track) {
        case true:
            print("play from file")
            playerItem = .init(url: getFileUrl(for: track))
        case false:
            print("play from url")
            playerItem = .init(url: track.previewUrl)
        }

        self.player = AVPlayer(playerItem:playerItem)
        player?.volume = 1.0
        player?.play()
    }
    
    func isDownloaded(track: Track) -> Bool {
        return FileManager.default.fileExists(atPath: getFileUrl(for: track).path)
    }
    
    func download(track: Track, completion: @escaping (URL?, Error?) -> ()) {
        URLSession.shared.downloadTask(with: track.previewUrl) { tempURL, _, error in
            if let tempURL = tempURL {
                do {
                    let url = self.getFileUrl(for: track)
                    try FileManager.default.moveItem(at: tempURL, to: url)
                    print("successfully downloaded: \(track.trackName)")
                    DispatchQueue.main.async {
                        completion(url, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    func getFileUrl(for track: Track) -> URL {
        let documentsDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let url = documentsDirectoryURL.appendingPathComponent(track.previewUrl.lastPathComponent)
        
        return url
    }
    
    
    class MusicSearchResponse: Codable {
        var tracks: [Track]
        
        enum CodingKeys: String, CodingKey {
            case tracks = "results"
        }
    }
}
