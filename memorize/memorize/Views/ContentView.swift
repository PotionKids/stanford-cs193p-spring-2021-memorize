//
//  ContentView.swift
//  memorize
//
//  Created by Krishnaswami Rajendren on 5/27/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(content: "🛵")
            CardView(content: "🏎")
            CardView(content: "🛶")
            CardView(content: "🚂")
        }
        .foregroundColor(.red)
        .padding()
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
