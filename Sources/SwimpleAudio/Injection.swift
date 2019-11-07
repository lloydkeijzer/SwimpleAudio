//
//  Injection.swift
//  
//
//  Created by Lloyd Keijzer on 07/11/2019.
//

import Foundation
import SwimpleInjection

internal let container: Container = {
    let container = Container()
    
    // Register services
    container.autoRegister(SoundLoader.self, as: .singleObject, initializer: SoundLoader.init)
    
    return container
}()
