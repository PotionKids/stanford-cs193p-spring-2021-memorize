//
//  Cardify.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/30/22.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var isFaceUp: Bool
    var isMatched: Bool
    var size: CGSize
    var rotation: Double
    
    init(isFaceUp: Bool, isMatched: Bool, size: CGSize) {
        self.isFaceUp = isFaceUp
        self.isMatched = isMatched
        self.size = size
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Context.cornerRadiusScaled(for: size))
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 2).foregroundColor(.red)
            } else if isMatched {
                shape.clear
            } else {
                shape.fill().foregroundColor(.red)
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct Context {
        static let cornerRadiusScaling: CGFloat = 0.25
        static func cornerRadiusScaled(for size: CGSize) -> CGFloat {
            size.min.scaled(by: cornerRadiusScaling)
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool, size: CGSize) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched, size: size))
    }
}
