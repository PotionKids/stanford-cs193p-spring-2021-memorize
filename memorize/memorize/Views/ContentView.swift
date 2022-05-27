//
//  ContentView.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/27/22.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🛵", "🏎", "🛶", "🚂", "🚢", "🚖", "🚀", "🚁", "🚡", "🛩", "🛰", "🛥", "🚤", "🚇", "🚄", "🚟", "🚔", "🛳"]
    
    @State var emojiCount = 5
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: screenWidth/5))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) {emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            .padding()
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
    }
    
    var remove: some View {
        Button {
            emojiCount -= (emojiCount > 1) ? 1 : 0
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View {
        Button {
            emojiCount += (emojiCount < emojis.count) ? 1 : 0
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
