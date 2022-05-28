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
        guard let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
                cards[chosenIndex].isNotFaceUp,
                cards[chosenIndex].isNotMatched
        else { return }
        match(cardAt: chosenIndex)
        updateFace(forCardAt: chosenIndex)
    }
    
    mutating func updateFace(forCardAt index: Int) {
        cards[index].flip()
    }
    
    mutating func match(cardAt chosenIndex: Int) {
        guard let potentialMatch = onlyFaceUpCard else {
            turnAllCardsFaceDownExcept(cardAt: chosenIndex)
            return
        }
        if cardsDoMatch(at: chosenIndex, and: potentialMatch) {
            cards[chosenIndex].isMatched = true
            cards[potentialMatch].isMatched = true
        }
        onlyFaceUpCard = nil
    }
    
    mutating func turnAllCardsFaceDown() {
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
    }
    
    mutating func turnAllCardsFaceDownExcept(cardAt index: Int) {
        turnAllCardsFaceDown()
        onlyFaceUpCard = index
    }
    
    func cardsDoMatch(at index: Int, and otherIndex: Int) -> Bool {
        return cards[index].content == cards[otherIndex].content
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
        
        var isNotFaceUp: Bool { !isFaceUp }
        var isNotMatched: Bool { !isMatched }
        
        mutating func flip() {
            isFaceUp.toggle()
        }
    }
}
