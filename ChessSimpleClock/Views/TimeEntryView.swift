//
//  TimeEntryView.swift
//  ChessSimpleClock
//
//  Created by Daniel Basaldua on 10/24/22.
//

import SwiftUI

let pastelGreen = Color(red: 0.38, green: 0.63, blue: 0.36)
 

struct TimeEntryView: View {
    @State private var selectedTime = "5 Minutes"
    
    let times = ["5 Minutes", "10 Minutes", "15 Minutes", "20 Minutes", "25 Minutes", "30 Minutes"]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Picker("Times", selection: $selectedTime) {
                    ForEach(times, id: \.self) { time in
                        Text(time)
                            .foregroundColor(.black)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.bottom)
                NavigationLink(destination: TimersView(selectedTime: selectedTime)) {
                    TimerButton(label: "Play", buttonColor: pastelGreen)
                }
                Spacer()
            }
            .background(Color(red: 0.88, green: 0.96, blue: 0.89))
            .navigationTitle("Choose your time")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .foregroundColor(.black)
    }
}

struct TimeEntryView_Previews: PreviewProvider {
    static var previews: some View {
        TimeEntryView()
    }
}
