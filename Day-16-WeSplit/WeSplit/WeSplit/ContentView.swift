//
//  ContentView.swift
//  WeSplit
//
//  Created by Somi Jeon on 2024-03-01.
//

import SwiftUI

struct ContentView: View {
    @State var tapCount = 0

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
        }
    }
}

#Preview {
    ContentView()
}
