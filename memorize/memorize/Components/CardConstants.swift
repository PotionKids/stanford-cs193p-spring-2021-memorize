//
//  CardConstants.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/31/22.
//

import SwiftUI

typealias Seconds = Double

struct CardConstants {
    static let color = Color.red
    static let aspectRatio: CGFloat = 2/3
    static let dealDuration: Seconds = 0.5
    static let totalDealDuration: Seconds = 0.5
    static let undealtHeight: CGFloat = 90
    static let undealtWidth: CGFloat = undealtHeight * aspectRatio
}
