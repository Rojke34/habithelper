//
//  AVPlayer+Ding.swift
//  Habits
//
//  Created by Kevin on 8/02/21.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        
        return AVPlayer(url: url)
    }()
}
