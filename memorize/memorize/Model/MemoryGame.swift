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
        private(set) var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        private(set) var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        let id: Int = UUID().hashValue
        
        var isNotFaceUp: Bool { !isFaceUp }
        var isNotMatched: Bool { !isMatched }
        
        mutating func turnFaceUp() { isFaceUp = true }
        mutating func turnFaceDown() { isFaceUp = false }
        mutating func flip() { isFaceUp.toggle() }
        mutating func match() { isMatched = true }
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus time available" for this card
        
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time is left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && isNotMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}

extension Array {
    var oneAndOnly: Element? {
        (count == 1) ? first : nil
    }
}
