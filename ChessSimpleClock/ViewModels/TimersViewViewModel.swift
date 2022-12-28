//
//  StopWatchManager.swift
//  ChessSimpleClock
//
//  Created by Daniel Basaldua on 10/23/22.
//

import SwiftUI
import AVFoundation
var audioPlayer: AVAudioPlayer?

enum stopWatchMode {
    case running
    case stopped
    case paused
    case finished
}

enum player {
    case white
    case black
}

class TimersViewViewModel: ObservableObject {
    @Published var whiteMode: stopWatchMode = .stopped
    @Published var whiteCountdownTime: String
    var whiteTimer = Timer()
    var whiteSecondsElapsed: Double = 0.0
    
    @Published var blackMode: stopWatchMode = .stopped
    @Published var blackCountdownTime: String
    var blackTimer = Timer()
    var blackSecondsElapsed: Double = 0.0
    
    let startTimeInSeconds: Double
    let originalTime: String
    
    //will help to determine which views to show
    @Published var hasBegan = false
    @Published var playerTurn: player = .white
    
    
    
    func whiteStart() {
        whiteMode = .running
        whiteCountdownTime = secondsToMinutesSecondsString(startTimeInSeconds-whiteSecondsElapsed)
        whiteTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if (self.whiteSecondsElapsed < self.startTimeInSeconds) {
                //Rounding to tenths prevents the countdownTime from going into the negatives
                self.whiteSecondsElapsed = self.roundToTenths(self.whiteSecondsElapsed + 0.1)
                self.whiteCountdownTime = self.secondsToMinutesSecondsString(self.startTimeInSeconds - self.whiteSecondsElapsed)
            } else {
                //The timer hit 00:00
                self.whiteMode = .finished
            }
        }
    }
    
    func blackStart() {
        blackMode = .running
        blackCountdownTime = secondsToMinutesSecondsString(startTimeInSeconds-blackSecondsElapsed)
        blackTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if (self.blackSecondsElapsed < self.startTimeInSeconds) {
                //Rounding to tenths prevents the countdownTime from going into the negatives
                self.blackSecondsElapsed = self.roundToTenths(self.blackSecondsElapsed + 0.1)
                self.blackCountdownTime = self.secondsToMinutesSecondsString(self.startTimeInSeconds - self.blackSecondsElapsed)
            } else {
                //The timer hit 00:00
                self.blackMode = .finished
            }
        }
    }
    
    func whitePause() {
        whiteTimer.invalidate()
        whiteMode = .paused
    }
    
    func blackPause() {
        blackTimer.invalidate()
        blackMode = .paused
    }
    
    func resetWhiteTimer() {
        whiteTimer.invalidate()
        whiteSecondsElapsed = 0.0
        whiteCountdownTime = originalTime
        whiteMode = .stopped
    }
    
    func resetBlackTimer() {
        blackTimer.invalidate()
        blackSecondsElapsed = 0.0
        blackCountdownTime = originalTime
        blackMode = .stopped
    }
    
    func toggleGameOn() {
        hasBegan = true
    }
    
    func toggleGameOff() {
        hasBegan = false
    }
    
    func secondsToMinutesSecondsString(_ totalSeconds: Double) -> String {
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
    
    func roundToTenths(_ num: Double) -> Double {
        return round(num * 10) / 10.0
    }
    
    func changePlayerTurn() {
        switch (playerTurn) {
        case .white:
            playerTurn = .black
        case .black:
            playerTurn = .white
        }
    }
    
    init(selectedTime: String) {
        switch (selectedTime) {
        case "5 Minutes":
            startTimeInSeconds = 300
            originalTime = "05:00"
            whiteCountdownTime = "05:00"
            blackCountdownTime = "05:00"
        case "10 Minutes":
            startTimeInSeconds = 600
            originalTime = "10:00"
            whiteCountdownTime = "10:00"
            blackCountdownTime = "10:00"
        case "15 Minutes":
            startTimeInSeconds = 900
            originalTime = "15:00"
            whiteCountdownTime = "15:00"
            blackCountdownTime = "15:00"
        case "20 Minutes":
            startTimeInSeconds = 1200
            originalTime = "20:00"
            whiteCountdownTime = "20:00"
            blackCountdownTime = "20:00"
        case "25 Minutes":
            startTimeInSeconds = 1500
            originalTime = "25:00"
            whiteCountdownTime = "25:00"
            blackCountdownTime = "25:00"
        case "30 Minutes":
            startTimeInSeconds = 1800
            originalTime = "30:00"
            whiteCountdownTime = "30:00"
            blackCountdownTime = "30:00"
        default:
            startTimeInSeconds = 300
            originalTime = "05:00"
            whiteCountdownTime = "05:00"
            blackCountdownTime = "05:00"
        }
        self.resetGame()
    }
    
    func resetGame() {
        hasBegan = false
        playerTurn = .white
        resetBlackTimer()
        resetWhiteTimer()
        toggleGameOff()
    }
    
    

    func playSound() {
        
        guard let url = Bundle.main.url(forResource: "switch", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = audioPlayer else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
