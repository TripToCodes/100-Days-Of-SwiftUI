import SwiftUI

struct ContentView: View {
    @State private var selectedPlay: PlayOption = .rock
    @State private var computersChoice: PlayOption = .rock
    @State private var showingScore = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var score = 0
    @State private var numberOfQuestions = 0
    @State private var isReady = false
    
    private enum PlayOption: String, CaseIterable {
        case rock = "✊"
        case scissors = "✌️"
        case paper = "🖐️"
        
        // By adding the `CaseIterable` protocol to the enum definition,
        // we don't have to define and manually update our own property
        // to access all the available cases
        //
        // static var allCases: [PlayOption] {
        //     return [.rock, .scissors, .paper]
        // }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 1, green: 1, blue: 0.7), location: 0.3),
                    .init(color: Color(red: 0.9, green: 0.7, blue: 1), location: 0.3)
                ], center: .top, startRadius: 400, endRadius: 700)
                .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text("Select to play")
                            .font(.title)
                        .bold()}
                    .font(.title)
                    
                    HStack(alignment: .center) {
                        Text(isReady ? computersChoice.rawValue : "?")
                            .font(.title)
                            .shadow(radius: 10)
                        
                        Section {
                            Picker("Choices", selection: $selectedPlay) {
                                ForEach(PlayOption.allCases, id: \.self) { option in
                                    Text(option.rawValue)
                                        .tag(option)
                                }
                            }
                            
                        }.padding(20)
                        
                        Button(action: playRound) {
                            Text("Play")
                                .font(.title)
                                .foregroundColor(.purple)
                                .bold()
                                .frame(width: 80)
                                .padding(5)
                                .background(.regularMaterial)
                                .clipShape(.capsule)
                            .shadow(radius: 2)}
                        
                    }
                    
                    Text("Score: \(score)")
                        .font(.title.bold())
                    
                    Spacer() // Pushes the content to the top.
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .clipShape(.rect(cornerRadius: 20))
                .padding(.top, 20)
                .alert(isPresented: $showingScore) {
                    Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        primaryButton: .default(Text("Back to Result")),
                        secondaryButton: .default(Text("Continue Playing")) {
                            replay()
                        })
                }
            }.navigationBarTitle("Rock, Scissors, Pager")
        }
    }
    
    func playRound() {
        computersChoice = PlayOption.allCases.randomElement()!
        isReady = true
        playTapped(selectedPlay)
    }
    
    private func playTapped(_ playOption: PlayOption) {
        numberOfQuestions += 1
        
        switch (playOption, computersChoice) {
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
            alertTitle = "Win"
            alertMessage = "You win!"
            score += 1
        case (.rock, .paper), (.scissors, .rock), (.paper, .scissors):
            alertTitle = "Lose"
            alertMessage = "You lose!"
        case (.rock, .rock), (.scissors, .scissors), (.paper, .paper):
            alertTitle = "Tie"
            alertMessage = "You tied!"
        }
        
        showingScore = true
        
        if numberOfQuestions == 3 {
            endGame()
        }
    }
    
    func replay() {
        selectedPlay = .rock // Optionally reset the player's selection
        showingScore = false // Reset to be ready for the next round
        isReady = false
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
