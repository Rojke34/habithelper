import Foundation
import AVFoundation

class CustomTimer: ObservableObject {
    
    @Published var secondsElapsed = 0
    
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    var lengthInMinutes: Int
    
    private var timer: Timer?
    private var frequency: TimeInterval { 1.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var startDate: Date?
    
    init(lengthInMinutes: Int = 0) {
        self.lengthInMinutes = lengthInMinutes
    }
    
    func startTimer() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            if let self = self, let startDate = self.startDate {
                let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
                self.update(secondsElapsed: Int(secondsElapsed))
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func update(secondsElapsed: Int) {
        self.secondsElapsed = secondsElapsed
        
        if secondsElapsed == lengthInSeconds  {
            player.play()
            stopTimer()
        }
            
    }
    
    func reset(lengthInMinutes: Int) {
        self.lengthInMinutes = lengthInMinutes
    }
}

extension Habit {
    var timer: CustomTimer {
        CustomTimer(lengthInMinutes: lengthInMinutes)
    }
}
