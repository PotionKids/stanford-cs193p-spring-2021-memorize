//
//  ContentView.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/27/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @State private var dealt = Set<Int>()
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom)
        {
            VStack {
                gameBody
                HStack(alignment: .bottom) {
                    shuffle
                    Spacer()
                    restart
                }
                .padding(.horizontal)
            }
            .padding()
            deckBody
                .padding()
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: CardView.CardConstants.aspectRatio) { card in
            cardView(for: card)
        }
        .foregroundColor(CardView.CardConstants.color)
    }
    
    @ViewBuilder
    func cardView(for card: Game.Card) -> some View {
        if isUndealt(card) || (card.isMatched && card.isNotFaceUp) {
            Rectangle().clear
        } else {
            CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.75)) {
                        game.choose(card)
                    }
                }
        }
    }
    
    private func zIndex(of card: Game.Card) -> Double {
        -(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0).double
    }
    
    func dealAnimation(for card: Game.Card) -> Animation {
        var delay = 0.0
        
        if let index = game.cards.firstIndex(where: {$0.id == card.id}) {
            delay = index.double * CardView.CardConstants.totalDealDuration / game.cards.count.double
        }
        
        return Animation.easeInOut(duration: CardView.CardConstants.dealDuration).delay(delay)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardView.CardConstants.undealtWidth, height: CardView.CardConstants.undealtHeight)
        .foregroundColor(CardView.CardConstants.color)
        .onTapGesture {
            // Deal the Cards
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    private func deal(_ card: Game.Card) {
        dealt.insert(card.id)
    }
    
    private func undeal(_ card: Game.Card) {
        dealt.remove(card.id)
    }
    
    private func isUndealt(_ card: Game.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation(.easeInOut(duration: 0.5)) {
                game.shuffle()
            }
        }
    }
    
    var restart: some View {
        Button("Restart") {
//            for card in game.cards {
//                withAnimation(dealAnimation(for: card)) {
//                    undeal(card)
//                }
//            }
//            game.restart()
            withAnimation {
                dealt = []
                game.restart()
            }
        }
    }
}

extension View {
    static var bounds: CGRect {
        UIScreen.main.bounds
    }
    static var screenWidth: CGFloat {
        bounds.width
    }
    static var screenHeight: CGFloat {
        bounds.height
    }
    
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
