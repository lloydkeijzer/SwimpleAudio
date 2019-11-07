//
//  UIControl+Sound.swift
//  
//
//  Created by Lloyd Keijzer on 07/11/2019.
//

#if !os(macOS)

import UIKit
import AVFoundation
import SwimpleInjection

fileprivate var bindedSounds: [UIControl:[BindedSound]] = [:]

fileprivate struct BindedSound {
    let sound: Sound
    let controlEvents: UIControl.Event
    let repeats: UInt
    let delay: DispatchTimeInterval
}

public extension UIControl {
    
    func addSound(
        named fileName: String,
        for controlEvents: Event,
        repeats: UInt = 0,
        delay: DispatchTimeInterval = .never
    ) {
        // Load Sound
        let soundLoader = container.resolve(SoundLoader.self)
        let sound = soundLoader.loadSound(named: fileName)
        
        // Bind Sound to UIControl.Event
        var currentlyBindedSounds = bindedSounds[self] ?? []
        currentlyBindedSounds.append(BindedSound(
            sound: sound,
            controlEvents: controlEvents,
            repeats: repeats,
            delay: delay
        ))
        bindedSounds[self] = currentlyBindedSounds
        addTarget(self, action: #selector(playSound(for:on:)), for: controlEvents)
    }
    
    func removeSounds() {
        bindedSounds.removeValue(forKey: self)
    }
}

private extension UIControl {
    
    @objc func playSound(for control: UIControl, on controlEvents: Event) {
        bindedSounds[control]?
            .filter({ $0.controlEvents == controlEvents })
            .forEach({ (bindedSound) in
                DispatchQueue.main.asyncAfter(deadline: .now() + bindedSound.delay) {
                    bindedSound.sound.player.numberOfLoops = Int(bindedSound.repeats)
                    bindedSound.sound.player.play()
                }
            })
    }
}

#endif
