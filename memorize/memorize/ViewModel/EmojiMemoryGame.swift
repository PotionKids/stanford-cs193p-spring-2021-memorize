//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/28/22.
//

import Foundation

typealias Emoji = String
typealias Game = MemoryGame<Emoji>

class EmojiMemoryGame: ObservableObject {
    typealias Card = Game.Card
    
    private static let emojis = [
                            "🛵", "🏎", "🛶", "🚂", "🚢", "🚖",
                            "🚀", "🚁", "🚡", "🛩", "🛰", "🛥",
                            "🚤", "🚇", "🚄", "🚟", "🚔", "🛳"
                        ]
    
    private static func createEmojiMemoryGame() -> Game {
        Game(numberOfCardPairs: 6) { EmojiMemoryGame.emojis[$0] }
    }
    
    @Published private var model = EmojiMemoryGame.createEmojiMemoryGame()
        
    var cards: [Card] {
        return model.cards
    }
    
    func choose(card: Card) {
        model.choose(card)
    }
}
