//
//  MemoryGame.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/28/22.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    private var onlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        print("indexOfTheOnlyFaceUpCard = \(String(describing: onlyFaceUpCard ?? nil))")
        guard let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
                cards[chosenIndex].isNotFaceUp,
                cards[chosenIndex].isNotMatched
        else { return }
        match(chosenIndex)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    mutating func turnAllCardsFaceDown() {
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
    }
    
    mutating func match(_ chosenIndex: Int) {
        guard let potentialMatch = onlyFaceUpCard else {
            turnAllCardsFaceDown()
            onlyFaceUpCard = chosenIndex
            return
        }
        cards[chosenIndex].isMatched = true
        cards[potentialMatch].isMatched = true
        onlyFaceUpCard = nil
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
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
        
        var isNotFaceUp: Bool {
            !isFaceUp
        }
        var isNotMatched: Bool {
            !isMatched
        }
    }
}
