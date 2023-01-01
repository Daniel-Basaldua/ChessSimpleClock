//
//  TimeEntryView.swift
//  ChessSimpleClock
//
//  Created by Daniel Basaldua on 10/24/22.
//

import SwiftUI

struct TimeEntryView: View {
    @State private var selectedTime = "5 Minutes"
    
    let times = ["5 Minutes", "10 Minutes", "15 Minutes", "20 Minutes", "25 Minutes", "30 Minutes"]
    
    /*Workaround to change navigationTitle foreground color.
     This will affect navigation titles and only works with inline styles
     */
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some View {
        ZStack {
            //Background
            Color("AppColor").ignoresSafeArea()
            
            //Body
            VStack {
                Spacer()
                
                timePicker
                
                NavigationLink(destination: TimersView(selectedTime: selectedTime)) {
                    ButtonLabel(label: "Play")
                }
                
                Spacer()
            }
            .padding(.bottom, 50)
            .navigationTitle("Choose your time")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension TimeEntryView {
    
    private var timePicker: some View {
        Picker("Times", selection: $selectedTime) {
            ForEach(times, id: \.self) { time in
                Text(time)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
            }
        }
        .pickerStyle(.wheel)
        .frame(maxWidth: .infinity)
    }
    
}

struct TimeEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TimeEntryView()
        }
    }
}
