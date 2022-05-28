//
//  CardView.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/27/22.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill().foregroundColor(card.isFaceUp ? .white : .red)
            shape.strokeBorder(lineWidth: 2)
            Text(card.isFaceUp ? card.content : "").font(.largeTitle)
        }
    }
}
