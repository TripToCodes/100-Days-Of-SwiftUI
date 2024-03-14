//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Somi Jeon on 2024-03-11.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Italy", "Spain", "Ireland", "Monaco", "Nigeria", "Poland", "UK", "US", "Ukraine"].shuffled() // shuffle(): shuffle in place, shuffled(): return a new array
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var alertTitle = ""
    @State private var score = 0
    @State private var numberOfQuestions = 0
    @State private var aNewGame = false
    @State private var alertMessage = ""
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Tap the flag of")
                Text(countries[correctAnswer])
            }
            .padding(20)
            .font(.title)
            
            ForEach(0..<3) { number in
                Button {
                    flagTapped(number)
                    generateAlertMessage(number)
                } label: {
                    Image(countries[number])
                }.alert(isPresented: $showingScore) {
                    Alert(title: Text(alertTitle), message: Text("\(alertMessage)"), dismissButton: .default(Text("Continue")) {
                        askQuestion()
                    }
                    )
                }
            }
            Text("Score: \(score)")
            
        }
        
    }
    
    func flagTapped(_ number: Int) {
        numberOfQuestions += 1
        if numberOfQuestions == 3 {
            alertTitle = "Game Over"
            aNewGame = true
            score = 0
        }
        if number == correctAnswer {
            alertTitle = "Correct"
            score += 1
        } else {
            alertTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func generateAlertMessage(_ number: Int) {
        if(alertTitle == "Correct") {
            alertMessage = "Great Job!"
        } else {
            alertMessage = "That's the flag of \(countries[number])"
        }
    }
    
    func newGame() {
        if numberOfQuestions == 8 {
            alertTitle = "Game Over"
            alertMessage = "Your final score is \(score)"
            aNewGame = true
            numberOfQuestions = 0
            score = 0
        } else {
            aNewGame = false
        }
    }
}



#Preview {
    ContentView()
}
