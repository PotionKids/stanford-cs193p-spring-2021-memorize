//
//  MemoryGame.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/28/22.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) else { return }
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
