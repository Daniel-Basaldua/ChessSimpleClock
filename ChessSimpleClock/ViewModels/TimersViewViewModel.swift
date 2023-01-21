//
//  StopWatchManager.swift
//  ChessSimpleClock
//
//  Created by Daniel Basaldua on 10/23/22.
//

import SwiftUI
import AVFoundation
var audioPlayer: AVAudioPlayer?

enum player {
    case white
    case black
}

class TimersViewViewModel: ObservableObject {
    //Used to update the Published variables repeatedly with the values stored in the stopwatches
    private var gameTimer: Timer?
    
    private var whiteStopWatch: StopWatch
    @Published var whiteCountdownTime: String
    
    private var blackStopWatch: StopWatch
    @Published var blackCountdownTime: String
    
    //will help to determine which views to show
    @Published var hasBegan = false
    @Published var playerTurn: player = .white
    @Published var gameOver: Bool = false
    
    init(selectedTime: String) {
        switch (selectedTime) {
        case "5 Minutes":
            whiteStopWatch = StopWatch(countdownTime: "05:00", startTimeInSeconds: 300)
            blackStopWatch = StopWatch(countdownTime: "05:00", startTimeInSeconds: 300)
        case "10 Minutes":
            whiteStopWatch = StopWatch(countdownTime: "10:00", startTimeInSeconds: 600)
            blackStopWatch = StopWatch(countdownTime: "10:00", startTimeInSeconds: 600)
        case "15 Minutes":
            whiteStopWatch = StopWatch(countdownTime: "15:00", startTimeInSeconds: 900)
            blackStopWatch = StopWatch(countdownTime: "15:00", startTimeInSeconds: 900)
        case "20 Minutes":
            whiteStopWatch = StopWatch(countdownTime: "20:00", startTimeInSeconds: 1200)
            blackStopWatch = StopWatch(countdownTime: "20:00", startTimeInSeconds: 1200)
        case "25 Minutes":
            whiteStopWatch = StopWatch(countdownTime: "25:00", startTimeInSeconds: 1500)
            blackStopWatch = StopWatch(countdownTime: "25:00", startTimeInSeconds: 1500)
        case "30 Minutes":
            whiteStopWatch = StopWatch(countdownTime: "30:00", startTimeInSeconds: 1800)
            blackStopWatch = StopWatch(countdownTime: "30:00", startTimeInSeconds: 1800)
        default:
            whiteStopWatch = StopWatch(countdownTime: "05:00", startTimeInSeconds: 300)
            blackStopWatch = StopWatch(countdownTime: "05:00", startTimeInSeconds: 300)
        }
        whiteCountdownTime = whiteStopWatch.countdownTime
        blackCountdownTime = blackStopWatch.countdownTime
        self.restartGame()
    }

    func toggleGameOn() {
        hasBegan = true
        whiteStopWatch.start()
    }
    
    private func toggleGameOff() {
        hasBegan = false
        whiteStopWatch.resetTimer()
        blackStopWatch.resetTimer()
    }
    
    //Change the turn of the player anytime the screen is tapped
    func changePlayerTurn() {
        switch (playerTurn) {
        case .white:
            whiteStopWatch.pause()
            blackStopWatch.start()
            playerTurn = .black
        case .black:
            blackStopWatch.pause()
            whiteStopWatch.start()
            playerTurn = .white
        }
    }
    
    private func resetGameVariables() {
        toggleGameOff()
        if let gameTimer {
            gameTimer.invalidate()
        }
        gameTimer = nil
        playerTurn = .white
        gameOver = false
        whiteCountdownTime = whiteStopWatch.countdownTime
        blackCountdownTime = blackStopWatch.countdownTime
    }
    
    func restartGame() {
        resetGameVariables()
        gamePlayLoop()
    }
    
    private func gamePlayLoop() {
        //keep checking the changed times in the countdown timer to redefine clock variables that are published
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if (self.whiteStopWatch.mode != .finished && self.blackStopWatch.mode != .finished) {
                if (self.whiteStopWatch.mode == .running) {
                    self.whiteCountdownTime = self.whiteStopWatch.countdownTime
                } else if (self.blackStopWatch.mode == .running) {
                    self.blackCountdownTime = self.blackStopWatch.countdownTime
                }
            } else {
                self.gameOver = true
                self.whiteStopWatch.pause()
                self.blackStopWatch.pause()
                self.gameTimer?.invalidate()
            }
        }
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
