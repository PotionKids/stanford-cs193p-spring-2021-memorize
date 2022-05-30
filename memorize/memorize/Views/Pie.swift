//
//  Pie.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/29/22.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.size.min / 2
        let start = CGPoint(
            x: center.x + radius * startAngle.cosine,
            y: center.y + radius * startAngle.sine
        )

        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        p.addLine(to: center)
        return p
    }
}

extension Double {
    var cgFloat: CGFloat {
        CGFloat(self)
    }
}

extension Angle {
    var cosine: CGFloat {
        cos(self.radians)
    }
    var sine: CGFloat {
        sin(self.radians)
    }
    var tangent: CGFloat {
        tan(self.radians)
    }
}
