//
//  ContentView.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/27/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ScrollView {
            grid(game.cards)
        }
        .foregroundColor(.red)
        .padding()
    }
    
    func grid(_ cards: [Game.Card]) -> some View {
        LazyVGrid(columns: [adaptiveGridItem(withMinimumFactor: 5)]) {
            ForEach(cards) {card in
                sized(card).onTapGesture { game.choose(card: card) }
            }
        }
    }
    
    func sized(_ card: Game.Card) -> some View {
        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
    }
    
    func adaptiveGridItem(withMinimumFactor factor: CGFloat) -> GridItem {
        GridItem(.adaptive(minimum: screenWidth/factor))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .previewInterfaceOrientation(.portrait)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
