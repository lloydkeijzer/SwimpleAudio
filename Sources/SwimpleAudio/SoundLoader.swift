//
//  SoundLoader.swift
//  
//
//  Created by Lloyd Keijzer on 07/11/2019.
//

import Foundation
import AVFoundation

internal final class SoundLoader {
    
    private lazy var loadedSounds: [Sound] = []
    
    internal func loadSound(named fileName: String) -> Sound {
        guard let sound = loadedSounds.first(where: { $0.fileName == fileName }) else {
            let path = Bundle.main.path(forResource: fileName, ofType:nil)!
            let url = URL(fileURLWithPath: path)
            guard let player = try? AVAudioPlayer(contentsOf: url) else {
                fatalError("Couldn't load sound: \(fileName)")
            }
            return Sound(fileName: fileName, player: player)
        }
        return sound
    }
}
