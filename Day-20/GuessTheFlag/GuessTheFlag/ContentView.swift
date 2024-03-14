import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Italy", "Spain", "Ireland", "Monaco", "Nigeria", "Poland", "UK", "US", "Ukraine"].shuffled() // shuffle(): shuffle in place, shuffled(): return a new array
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var showingScore = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var score = 0
    @State private var numberOfQuestions = 0
    
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
                } label: {
                    Image(countries[number])
                }
            }
            Text("Score: \(score)")
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                askQuestion()
            })
        }
    }

    func flagTapped(_ number: Int) {
        numberOfQuestions += 1
        if number == correctAnswer {
            alertTitle = "Correct"
            score += 1
            alertMessage = "Great Job!"
        } else {
            alertTitle = "Wrong"
            alertMessage = "That's the flag of \(countries[number])"
        }
        if numberOfQuestions == 3 {
            endGame()
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
    
    func endGame() {
        alertTitle = "Game Over"
        alertMessage = "Your final score is \(score) / 3"
        showingScore = true
        resetGame()
    }
    
    func resetGame() {
        numberOfQuestions = 0
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
