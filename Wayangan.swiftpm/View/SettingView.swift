//
//  File.swift
//  
//
//  Created by Ahmad Fariz on 15/04/23.
//

import Foundation
import SwiftUI

struct SettingView: View {
    @EnvironmentObject var player: AudioPlayer
    @State private var isMuted = false
    @State private var volume: Float = 0.5
    
    var body: some View {
        VStack {
            Text("Settings")
            Slider(value: $volume, in: 0...1) { _ in
                player.setVolume(volume)
            }
            .padding()
            Button(action: {
                isMuted.toggle()
                player.setVolume(isMuted ? 0 : volume)
            }) {
                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}


