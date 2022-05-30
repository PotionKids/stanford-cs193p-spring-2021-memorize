//
//  AspectVGrid.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/29/22.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                grid(items, size: geometry.size)
            }
            Spacer(minLength: 0)
        }
    }
    
    func grid(_ items: [Item], size: CGSize) -> some View {
        let width = widthThatFits(itemCount: items.count, in: size, itemAspectRatio: aspectRatio)
        return LazyVGrid(columns: [adaptiveVGridItem(with: width)], spacing: 0) {
            ForEach(items) {item in
                content(item)
                    .padding(4)
            }
        }
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / columnCount.cgFloat
            let itemHeight = itemWidth / itemAspectRatio
            if rowCount.cgFloat * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / columnCount.cgFloat)
    }
    
    func adaptiveGridItem(withMinimumFactor factor: CGFloat) -> GridItem {
        GridItem(.adaptive(minimum: screenWidth/factor)).spaced(by: 0)
    }
    
    func adaptiveVGridItem(with width: CGFloat) -> GridItem {
        GridItem(.adaptive(minimum: width)).spaced(by: 0)
    }
}

extension Int {
    var cgFloat: CGFloat {
        CGFloat(self)
    }
}

extension GridItem {
    func spaced(by value: CGFloat) -> GridItem {
        var gridItem = self
        gridItem.spacing = 0
        return gridItem
    }
}
