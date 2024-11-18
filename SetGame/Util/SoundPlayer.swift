//
//  SoundPlayer.swift
//  SetGame
//
//  Created by Dexter Stephens on 10/26/23.
//

import Foundation
import AVFoundation

struct SoundPlayer {
    var player: AVAudioPlayer?
    
    mutating func playSound(named soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: nil) else {
            //don't worry, just don't play it
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(filePath: path))
            player?.play()
        } catch {
            //don't worry, just don't play the sound
        }
    }
}
