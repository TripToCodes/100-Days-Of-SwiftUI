import SwiftUI

struct ContentView: View {
    @State private var playOptions = ["hand.thumbsup.fill", "hand.point.up.fill", "hand.raised.fingers.spread.fill"]
    @State private var selectedIndex: Int? = nil // Updated to Optional to initially not show any selection
    @State private var computersChoice = Int.random(in: 0..<3)
    @State private var showingScore = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var score = 0
    @State private var numberOfQuestions = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 1, green: 0.6, blue: 0.5), location: 0.3),
                .init(color: Color(red: 1, green: 0.8, blue: 0.4), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack {
                    Text("Rock, Scissors, Paper")
                        .font(.title)
                        .bold()
                    Button(action: playRound) {
                        Text("Play")
                            .font(.title)
                            .bold()
                    }
                    
                }
                .padding(20)
                .font(.title)
                
                HStack(alignment: .center, spacing: 80) {
                    Image(systemName: selectedIndex != nil ? playOptions[computersChoice] : "questionmark.diamond")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .shadow(radius: 10)
                    
                    Section {
                        Picker("Choices", selection: $selectedIndex) {
                            ForEach(0..<playOptions.count, id: \.self) { index in
                                Image(systemName: playOptions[index])
                                    .tag(index)
                            }
                        }
                    }
                    
                }
                
                 Text("Score: \(score)")
                    .font(.title.bold())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
            .alert(isPresented: $showingScore) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                    replay()
                })
            }
        }
    }
    
    func playRound() {
        guard let selectedIndex = selectedIndex else { return }
        playTapped(selectedIndex)
    }
    
     func playTapped(_ number: Int) {
        numberOfQuestions += 1
         
        if number == computersChoice {
            alertTitle = "Tie"
            alertMessage = "Try Again!"
        }
        
        if number == 0 {
            if computersChoice == 1 { // rock vs scissors
                alertTitle = "Win"
                alertMessage = "Rock beats Scissors"
                score += 1
            }
            if   computersChoice == 2 { // rock vs paper
                alertTitle = "Lose"
                alertMessage = "Paper beats Rock"
            }
            
        }
        
        if number == 1 {
            if computersChoice == 0 { // scissors vs rock
                alertTitle = "Lose"
                alertMessage = "Rock beats Scissors"
            }
            if computersChoice == 2 { // scissors vs paper
                alertTitle = "Win"
                alertMessage = "Scissors beats Paper"
                score += 1
            }
        }
        
        if number == 2 {
            if computersChoice == 0 { // paper vs rock
                alertTitle = "Win"
                alertMessage = "Paper beats Rock"
                score += 1
            }
            if computersChoice == 1 { // paper vs scissors
                alertTitle = "Lose"
                alertMessage = "Scissors beats Paper"
            }
        }
        
        showingScore = true

        if numberOfQuestions == 3 {
            endGame()
        }
    }
    
//    func replay() {
//        computersChoice = Int.random(in: 0..<3)
//    }
    
    func replay() {
         selectedIndex = nil // Optionally reset the player's selection
         showingScore = false // Reset to be ready for the next round
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
        replay()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
