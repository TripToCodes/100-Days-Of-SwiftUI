//
//  ContentView.swift
//  BetterRest
//
//  Created by Somi Jeon on 2024-03-21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount:Double = 8.0
    @State private var wakeUp = Date.now
    
    
    var body: some View {
        Text(Date.now.formatted(date: .long, time: .shortened))
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
     }
}

#Preview {
    ContentView()
}
