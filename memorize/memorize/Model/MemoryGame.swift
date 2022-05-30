//
//  MemoryGame.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/28/22.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    private var onlyFaceUpCardIndex: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
                cards[chosenIndex].isNotFaceUp,
                cards[chosenIndex].isNotMatched
        else { return }
        match(cardAt: chosenIndex)
        updateFace(forCardAt: chosenIndex)
    }
    
    mutating func updateFace(forCardAt index: Int) {
        cards[index].turnFaceUp()
    }
    
    mutating func match(cardAt chosenIndex: Int) {
        guard let potentialMatch = onlyFaceUpCardIndex else {
            turnAllCardsFaceDownExcept(cardAt: chosenIndex)
            return
        }
        if cardsDoMatch(at: chosenIndex, and: potentialMatch) {
            updateMatched(forCardAt: chosenIndex, and: potentialMatch)
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func updateMatched(forCardAt index: Int, and otherIndex: Int) {
        cards[index].match()
        cards[otherIndex].match()
    }
    
    mutating func turnAllCardsFaceDown() {
        cards.indices.forEach { cards[$0].turnFaceDown() }
    }
    
    mutating func turnAllCardsFaceDownExcept(cardAt index: Int) {
        turnAllCardsFaceDown()
        cards[index].turnFaceUp()
    }
    
    func cardsDoMatch(at index: Int, and otherIndex: Int) -> Bool {
        return cards[index].content == cards[otherIndex].content
    }
    
    init(numberOfCardPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = Array(0..<numberOfCardPairs)
            .map {
                createCardContent($0)
            }
            .flatMap {
                [Card(content: $0), Card(content: $0)]
            }
        shuffle()
    }
    
    struct Card: Identifiable {
        private(set) var isFaceUp = false
        private(set) var isMatched = false
        let content: CardContent
        let id: Int = UUID().hashValue
        
        var isNotFaceUp: Bool { !isFaceUp }
        var isNotMatched: Bool { !isMatched }
        
        mutating func turnFaceUp() { isFaceUp = true }
        mutating func turnFaceDown() { isFaceUp = false }
        mutating func flip() { isFaceUp.toggle() }
        mutating func match() { isMatched = true }
    }
}

extension Array {
    var oneAndOnly: Element? {
        (count == 1) ? first : nil
    }
}
