//
//  CardView.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/27/22.
//

import SwiftUI

struct CardView: View {
    let card: Game.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: (0-90).degrees, endAngle:((1 - animatedBonusRemaining) * 360 - 90).degrees)
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: (0-90).degrees, endAngle:((1 - card.bonusRemaining) * 360 - 90).degrees)
                    }
                }
                .foregroundColor(.teal)
                .padding(5)
                .opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 0.75).repeatCount(2, autoreverses: false).delay(0.5), value: card.isMatched)
                    .font(Font.proportional(for: size, scaledBy: Context.fontScaling))
            }
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched, size: geometry.size)
        }
    }
    
    private struct Context {
        static let fontScaling: CGFloat = 0.32
    }
    
    typealias Seconds = Double

    struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Seconds = 0.5
        static let totalDealDuration: Seconds = 0.5
        static let undealtHeight: CGFloat = screenWidth / 4
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
    }
}


extension Shape {
    var clear: some View {
        self.opacity(0)
    }
}

extension CGSize {
    var min: CGFloat {
        Swift.min(width, height)
    }
}

extension CGFloat {
    func scaled(by scaling: CGFloat) -> CGFloat {
        self * scaling
    }
}

extension Font {
    static func proportional(for size: CGSize, scaledBy factor: CGFloat) -> Font {
        Font.system(size: size.min.scaled(by: factor))
    }
}

extension Int {
    var double: Double {
        Double(self)
    }
    var degress: Angle {
        Angle(degrees: self.double)
    }
    var radians: Angle {
        Angle(radians: self.double)
    }
}

extension Double {
    var degrees: Angle {
        Angle(degrees: self)
    }
    var radians: Angle {
        Angle(radians: self)
    }
}
