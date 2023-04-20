//
//  File.swift
//  
//
//  Created by Ahmad Fariz on 20/04/23.
//

import Foundation
import SwiftUI
import AVFoundation

class AudioPlayer: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    func play() {
        guard let sound = Bundle.main.path(forResource: "BackSound.mp3", ofType: "mp3") else {
            return
        }
        
        let url = URL(fileURLWithPath: sound)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    func setVolume(_ volume: Float) {
        audioPlayer?.volume = volume
    }
}
