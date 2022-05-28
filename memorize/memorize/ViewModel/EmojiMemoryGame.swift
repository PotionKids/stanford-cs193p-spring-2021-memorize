//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/28/22.
//

import Foundation

typealias Game = MemoryGame<String>

class EmojiMemoryGame: ObservableObject {
    
    static let emojis = [
                            "🛵", "🏎", "🛶", "🚂", "🚢", "🚖",
                            "🚀", "🚁", "🚡", "🛩", "🛰", "🛥",
                            "🚤", "🚇", "🚄", "🚟", "🚔", "🛳"
                        ]
    
    static func createEmojiMemoryGame() -> Game {
        Game(numberOfPairsOfCards: 6) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    @Published private var model: Game = EmojiMemoryGame.createEmojiMemoryGame()
        
    var cards: [Game.Card] {
        return model.cards
    }
    
    func choose(card: Game.Card) {
        model.choose(card)
    }
}
