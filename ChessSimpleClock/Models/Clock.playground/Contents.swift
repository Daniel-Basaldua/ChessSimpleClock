import UIKit

//Must use a class in order for the async timer to update variables
class Clock {
    var mode: stopWatchMode = .stopped
    var timer = Timer()
    var secondsElapsed: Double = 0.0
    var countdownTime: String = "5:00"
    let startTimeInSeconds: Double = 300
    let originalTime: String = "5:00"
    
    func start() {
        mode = .running
        countdownTime = secondsToMinutesSecondsString(startTimeInSeconds-secondsElapsed)
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if (self.secondsElapsed < self.startTimeInSeconds) {
                //Rounding to tenths prevents the countdownTime from going into the negatives
                self.secondsElapsed = self.roundToTenths(self.secondsElapsed + 0.1)
                self.countdownTime = self.secondsToMinutesSecondsString(self.startTimeInSeconds - self.secondsElapsed)
            } else {
                //The timer hit 00:00
                self.mode = .finished
            }
        }
    }
    
    func pause() {
        timer.invalidate()
        mode = .paused
    }
    
    func resetTimer() {
        timer.invalidate()
        secondsElapsed = 0.0
        countdownTime = originalTime
        mode = .stopped
    }
    
    private func secondsToMinutesSecondsString(_ totalSeconds: Double) -> String {
        let minutes = floor(totalSeconds / 60)
        let seconds = floor(totalSeconds.truncatingRemainder(dividingBy: 60.0))
        
        var minutesString: String = String(Int(minutes))
        var secondsString: String = String(Int(seconds))
        if (minutes < 10) {
            minutesString = "0\(minutesString)"
        }
        if (seconds < 10) {
            secondsString = "0\(secondsString)"
        }
        return "\(minutesString):\(secondsString)"
    }
    
    private func roundToTenths(_ num: Double) -> Double {
        return round(num * 10) / 10.0
    }
}

var timer = Timer()
var clock = Clock()
clock.start()

timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
    print(clock.countdownTime)
}
