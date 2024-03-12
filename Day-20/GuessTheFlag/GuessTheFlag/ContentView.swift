//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Somi Jeon on 2024-03-11.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Italy", "Spain"].shuffled() // shuffle(): shuffle in place, shuffled(): return a new array
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfQuestions = 0
    @State private var aNewGame = false
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text("Tap the flag of")
                Text(countries[correctAnswer])
            }
            
            ForEach(0..<3) { number in
                Button {
                    flagTapped(number)
                } label: {
                    Image(countries[number])
                }.alert(isPresented: $showingScore) {
                    Alert(title: Text(scoreTitle), message: Text("Your score is \(score) / 3"), dismissButton: .default(Text("Continue")) {
                        askQuestion()
                    }
                    )
                }
            }
        }
        
    }
    
    func flagTapped(_ number: Int) {
        numberOfQuestions += 1
        if numberOfQuestions == 3 {
            scoreTitle = "Game Over"
            aNewGame = true
            score = 0
        }
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}



#Preview {
    ContentView()
}
