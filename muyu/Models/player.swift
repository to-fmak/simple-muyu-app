//
//  player.swift
//  muyu
//
//  Created by Fumiaki Tou on 2023/11/26.
//

import AVFoundation
import Foundation
import UIKit

struct Player {
    let sound = try!  AVAudioPlayer(data: NSDataAsset(name: "sound2")!.data)

    func playSound() {
        self.sound.stop()
        self.sound.currentTime = 0.0
        self.sound.play()
        let audioSession = AVAudioSession.sharedInstance()
        // 在静音模式下播放
        try! audioSession.setCategory(.playback)
    }
    
    func autoPlaySound(speed: Double) -> Timer{
        self.sound.stop()
        self.sound.currentTime = 0.0
        let workingTimer = Timer.scheduledTimer(withTimeInterval: 1.0 - speed, repeats: true) { timer in
            self.playSound()
        }
        
        return workingTimer
    }
    
    func stopAutoPlaySound(workingTimer: Timer) {
        workingTimer.invalidate()
    }
}
