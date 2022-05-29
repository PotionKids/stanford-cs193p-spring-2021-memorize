//
//  Cardify.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/30/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var isMatched: Bool
    var size: CGSize
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Context.cornerRadiusScaled(for: size))
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 2).foregroundColor(.red)
                content
            } else if isMatched {
                shape.clear
            } else {
                shape.fill().foregroundColor(.red)
            }
        }
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
