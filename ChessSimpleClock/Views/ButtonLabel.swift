//
//  ButtonLabel.swift
//  ChessSimpleClock
//
//  Created by Daniel Basaldua on 12/31/22.
//

import SwiftUI

struct ButtonLabel: View {
    let label: String
    let buttonColor: Color
    
    var body: some View {
        Text(label)
            .foregroundColor(.white)
            .fontWeight(.medium)
            .padding(.vertical, 20)
            .padding(.horizontal, 90)
            .background(buttonColor)
            .cornerRadius(10)
    }
}

struct ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabel(label: "TESTING", buttonColor: Color("ButtonColor"))
            .previewLayout(.sizeThatFits)
    }
}
