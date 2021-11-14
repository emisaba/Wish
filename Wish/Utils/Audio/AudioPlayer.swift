import UIKit
import AVFoundation

struct AudioPlayer {
    
    static private var player: AVAudioPlayer?
    
    static func startMusic() {
        
        let urlString = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else { return }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            guard let player = player else { return }
            player.play()
            
        } catch {
            print("player error")
        }
    }
}
