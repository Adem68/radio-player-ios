//
//  RadioPlayer.swift
//  RadioPlayer
//
//  Created by Adem Özcan on 17.10.2021.
//

import Foundation
import MediaPlayer
import AVKit
import Kingfisher

class RadioPlayer: ObservableObject {
    static let instance = RadioPlayer()
    var player = AVPlayer()
    
    private init() {}
    
    @Published var isPlaying = false
    @Published var currentRadio: RadioModel? = nil
    
    func initPlayer(url: String) {
        guard let url = URL(string: url) else { return }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }
    
    func playAudioBackground() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.spokenAudio, options: [.defaultToSpeaker, .allowAirPlay, .allowBluetoothA2DP])
            try AVAudioSession.sharedInstance().setActive(true)
            setupCommandCenter()
        } catch {
            print(error)
        }
    }
    
    func stop(){
        isPlaying = false
        player.pause()
    }
    
    func play(_ radio: RadioModel) {
        currentRadio = radio
        player.volume = 0.1
        player.play()
        isPlaying = true
        playAudioBackground()
    }
    
    private func setupCommandCenter() {
        getImageFromURL(from: URL(string: currentRadio!.imageUrl)!) { [weak self] image in
            guard let self = self,
                let downloadedImage = image else {
                    return
            }
            let artwork = MPMediaItemArtwork.init(boundsSize: downloadedImage.size, requestHandler: { _ -> UIImage in
                return downloadedImage
            })
            
            self.setupNowPlayingInfo(with: artwork)
        }
        
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.player.play()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.player.pause()
            return .success
        }
    }
    
    func getImageFromURL(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if let data = data {
                completion(UIImage(data:data))
            }
        }).resume()
    }
    
    func setupNowPlayingInfo(with artwork: MPMediaItemArtwork) {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: self.currentRadio!.name as String,
            MPMediaItemPropertyArtist: "Radio Player",
            MPMediaItemPropertyArtwork: artwork,
            MPMediaItemPropertyPlaybackDuration: 0,
            MPNowPlayingInfoPropertyIsLiveStream: true
        ]
    }
}
