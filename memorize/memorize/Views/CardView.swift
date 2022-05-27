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
            shape.stroke(lineWidth: 3.5)
            shape.fill()
                .foregroundColor(isFaceUp ? .white : .red)
            Text(isFaceUp ? content : "")
                .font(.largeTitle)
        }
        .onTapGesture { isFaceUp.toggle() }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
