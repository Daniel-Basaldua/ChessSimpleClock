//
//  ContentView.swift
//  ChessSimpleClock
//
//  Created by Daniel Basaldua on 10/23/22.
//

import SwiftUI

struct TimersView: View {
    @ObservedObject var vm: TimersViewViewModel
    
    init(selectedTime: String) {
        self.vm = TimersViewViewModel(selectedTime: selectedTime)
    }
    
    var body: some View {
        ZStack {
            //Background
            Color("AppColor").ignoresSafeArea()
            
            if self.vm.hasBegan == false {
                welcomeScreen
            } else {
                if (vm.gameOver == true) {
                    gameOverScreen
                }
                else {
                    HStack(spacing: 0) {
                        ZStack {
                            Color.white.ignoresSafeArea()
                            VStack {
                                Spacer()
                                Text("Whites turn")
                                    .font(.custom("Avenir", size: 50))
                                    .foregroundColor(.black)
                                    .opacity(vm.playerTurn == .white ? 1.0 : 0.0)
                                Spacer()
                                Text("\(vm.whiteCountdownTime)")
                                    .font(.custom("Avenir", size: 100))
                                    .padding(.bottom, 140)
                                    .foregroundColor(.black)
                            }
                        }
                        .onTapGesture {
                            if vm.playerTurn == .white {
                                vm.changePlayerTurn()
                                vm.playSound()
                            }
                        }
                        ZStack {
                            Color.black.ignoresSafeArea()
                            VStack {
                                Spacer()
                                Text("Blacks turn")
                                    .font(.custom("Avenir", size: 50))
                                    .foregroundColor(.white)
                                    .opacity(vm.playerTurn == .black ? 1.0 : 0.0)
                                Spacer()
                                Text("\(vm.blackCountdownTime)")
                                    .font(.custom("Avenir", size: 100))
                                    .padding(.bottom, 150)
                                    .foregroundColor(.white)
                            }
                        }
                        .onTapGesture {
                            if vm.playerTurn == .black {
                                vm.changePlayerTurn()
                                vm.playSound()
                            }
                        }
                    }
                }
            }
        }
        .onDisappear {
            self.vm.restartGame()
        }
        
    }
    
}

extension TimersView {
    private var welcomeScreen: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 6) {
                Text("White will go first")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("once you press begin game the timer will start. To end your turn tap anywhere your color is shown")
                    .font(.title3)
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: 500)
            .padding(.horizontal, 10)
            .padding(.bottom, 30)
            Button {
                self.vm.toggleGameOn()
                self.vm.playSound()
            } label: {
                ButtonLabel(label: "BEGIN GAME")
            }
            Spacer()
        }
        .padding(.bottom, 50)
    }
    
    private var gameOverScreen: some View {
        VStack {
            Text(vm.playerTurn == .white ? "White ran out of time" : "Black ran out of time")
                .font(.custom("Avenir", size: 50))
                .foregroundColor(.black)
            Button {
                vm.restartGame()
            } label: {
                ButtonLabel(label: "Play again?")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TimersView(selectedTime: "5 Minutes")
        }
        .navigationTitle("TESTING")
        .navigationBarTitleDisplayMode(.inline)
    }
}
