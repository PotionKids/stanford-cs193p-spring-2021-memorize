//
//  ContentView.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/27/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            gameBody
            shuffle
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            cardView(for: card)
        }
    }
    
    @ViewBuilder
    func cardView(for card: Game.Card) -> some View {
        if card.isMatched && card.isNotFaceUp {
            Rectangle().clear
        } else {
        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
            .onTapGesture {
                game.choose(card)
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
}

extension View {
    var bounds: CGRect {
        UIScreen.main.bounds
    }
    var screenWidth: CGFloat {
        bounds.width
    }
    var screenHeight: CGFloat {
        bounds.height
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .previewInterfaceOrientation(.portrait)
    }
}
