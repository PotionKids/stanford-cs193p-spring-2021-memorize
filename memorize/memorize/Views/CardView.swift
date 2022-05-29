//
//  CardView.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/27/22.
//

import SwiftUI

struct CardView: View {
    let card: Game.Card
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack {
                Pie(startAngle: 270.degrees, endAngle: 0.degrees).foregroundColor(.teal).padding(5).opacity(0.5)
                Text(card.content).font(Font.proportional(for: size, scaledBy: Context.fontScaling))
            }
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched, size: geometry.size)
        }
    }
    
    private struct Context {
        static let fontScaling: CGFloat = 0.32
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
