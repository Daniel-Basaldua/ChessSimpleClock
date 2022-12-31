//
//  ContentView.swift
//  ChessSimpleClock
//
//  Created by Daniel Basaldua on 10/23/22.
//

import SwiftUI

struct TimersView: View {
    @ObservedObject var vm: TimersViewViewModel //= TimersViewViewModel()
    
    init(selectedTime: String) {
        self.vm = TimersViewViewModel(selectedTime: selectedTime)
    }
    
    var body: some View {
        //ZStack is for the background color to change
        ZStack {
            Color.init(red: 0.88, green: 0.96, blue: 0.89).ignoresSafeArea()
            if self.vm.hasBegan == false {
                VStack {
                    Text("White will go first")
                        .font(.title)
                        .padding(.bottom)
                        .foregroundColor(.black)
                    Text("once you press begin game the timer will start")
                        .font(.title3)
                        .padding(.bottom)
                        .foregroundColor(.black)
                    Text("To end your turn tap anywhere your color is shown")
                        .font(.title3)
                        .padding(.bottom)
                        .foregroundColor(.black)
                    Button {
                        self.vm.toggleGameOn()
                        self.vm.whiteStart()
                        self.vm.playSound()
                    } label: {
                        ButtonLabel(label: "BEGIN GAME", buttonColor: Color("ButtonColor"))
                    }
                    .padding(.bottom, 100)
                }
            } else if self.vm.hasBegan == true {
                if (vm.whiteMode == .finished) {
                    VStack {
                        Text("White ran out of time")
                            .font(.custom("Avenir", size: 50))
                            .foregroundColor(.black)
                        Button {
                            vm.resetGame()
                        } label: {
                            ButtonLabel(label: "Play again?", buttonColor: Color("ButtonColor"))
                        }
                    }
                } else if vm.blackMode == .finished {
                    VStack {
                        Text("Black ran out of time")
                            .font(.custom("Avenir", size: 50))
                            .foregroundColor(.black)
                        Button {
                            vm.resetGame()
                        } label: {
                            ButtonLabel(label: "Play again?", buttonColor: Color("ButtonColor"))
                        }
                    }
                }
                else {
                    HStack(spacing: 0) {
                        ZStack {
                            Color.white.ignoresSafeArea()
                            VStack {
                                Text("Whites turn")
                                    .font(.custom("Avenir", size: 50))
                                    .foregroundColor(.black)
                                    .opacity(vm.playerTurn == .white ? 1.0 : 0.0)
                                Spacer()
                                Text("\(vm.whiteCountdownTime)")
                                    .font(.custom("Avenir", size: 100))
                                    .padding(.bottom, 140)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                        .onTapGesture {
                            if vm.playerTurn == .white {
                                vm.whitePause()
                                vm.blackStart()
                                vm.changePlayerTurn()
                                vm.playSound()
                            }
                        }
                        ZStack {
                            Color.black.ignoresSafeArea()
                            VStack {
                                Text("Blacks turn")
                                    .font(.custom("Avenir", size: 50))
                                    .foregroundColor(.white)
                                    .opacity(vm.playerTurn == .black ? 1.0 : 0.0)
                                Spacer()
                                Text("\(vm.blackCountdownTime)")
                                    .font(.custom("Avenir", size: 100))
                                    .padding(.bottom, 150)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .onTapGesture {
                            if vm.playerTurn == .black {
                                vm.blackPause()
                                vm.whiteStart()
                                vm.changePlayerTurn()
                                vm.playSound()
                            }
                        }
                    }
                }
            }
        }
        .onDisappear {
            self.vm.resetGame()
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimersView(selectedTime: "5 Minutes")
    }
}
