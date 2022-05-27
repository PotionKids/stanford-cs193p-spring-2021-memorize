//
//  CardView.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/27/22.
//

import SwiftUI

struct CardView: View {
    var content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill()
                .foregroundColor(isFaceUp ? .white : .red)
            shape.strokeBorder(lineWidth: 2)
            Text(isFaceUp ? content : "")
                .font(.largeTitle)
        }
        .onTapGesture { isFaceUp.toggle() }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
