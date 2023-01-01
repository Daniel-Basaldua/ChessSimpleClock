//
//  ChessSimpleClockApp.swift
//  ChessSimpleClock
//
//  Created by Daniel Basaldua on 10/23/22.
//

import SwiftUI

@main
struct ChessSimpleClockApp: App {
    //Workaround to change navigationTitle foreground color.
    /*
     This will affect navigation titles and only works with inline styles
     */
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TimeEntryView()
            }
        }
    }
}
