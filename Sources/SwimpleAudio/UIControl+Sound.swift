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

public extension UIControl {
    
    func addSound(
        named fileName: String,
        for controlEvents: Event,
        repeats: UInt = 0,
        delay: DispatchTimeInterval = .seconds(0)
    ) {
        // Load Sound
        let soundLoader = container.resolve(SoundLoader.self)
        let sound = soundLoader.loadSound(named: fileName)
        
        // Bind Sound to UIControl.Event
        addAction(for: controlEvents) {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                sound.player.numberOfLoops = Int(repeats)
                sound.player.play()
            }
        }
    }
    
    func removeTargets() {
        removeTarget(nil, action: nil, for: .allEvents)
    }
}

@objc private class ClosureSleeve: NSObject {
    let closure: ()->()

    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }

    @objc func invoke () {
        closure()
    }
}

private extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

#endif
