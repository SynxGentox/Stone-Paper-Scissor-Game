//
//  ContentView.swift
//  Stone,Paper,Scissors
//
//  Created by Aryan Verma on 10/03/26.
//

import SwiftUI


enum GamePhase {
    case choosing
    case result
}



enum GameResult: String {
    case waiting = "Make Your Move!"
    case win     = "You Win! 🎉"
    case lose    = "You Lose! 💀"
    case tie     = "It's a Tie! 🤝"
}



enum Choices: String, CaseIterable {
    case stone    = "Stone"
    case paper    = "Paper"
    case scissors = "Scissors"
    
    var title: String { rawValue }
    
    func result(against opponent: Choices) -> GameResult {
        if self == opponent {
            return .tie
        }
        
        let winAgainst: [Choices: Choices] = [
            .stone  : .scissors,
            .paper  : .stone,
            .scissors: .paper
        ]
        
        return winAgainst[self] == opponent ? .win : .lose
    }
}




struct BodyText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2.weight(.black))
            .foregroundStyle(Color.white)
            .fontDesign(.rounded)
            .padding()
    }
}

extension View {
    func bodyText() -> some View {
        self.modifier(BodyText())
    }
}




struct ContentView: View {
    @State private var gameState: GamePhase = .choosing
    @State private var computerChoice: Choices = .stone
    @State private var playerChoice: Choices = .stone
    @State private var gameResult: GameResult = .waiting
    @State private var score = (wins: 0, losses: 0, ties: 0)
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack{
                Text("Old School Game!")
                    .font(.largeTitle.weight(.heavy))
                    .fontDesign(.rounded)
                    .padding()
                
                
                Rectangle()
                    .fill(.black)
                    .frame(height: 5)
                    .shadow(radius: 5,x: 0,y: 5)
                
                HStack(spacing: 24) {
                    ScoreLabel(title: "Wins",   value: score.wins)
                    ScoreLabel(title: "Losses", value: score.losses)
                    ScoreLabel(title: "Ties",   value: score.ties)
                }
                .padding(.bottom, 8)
                
                Rectangle()
                    .fill(.black)
                    .frame(height: 5)
                    .shadow(radius: 5,x: 0,y: -5)
                
                
                Text("Computer")
                    .bodyText()
                
                Text(gameState == .result ? "Computer Choice \(computerChoice.title)" : "Waiting for the Result")
                .font(.system(size: 20, weight: .heavy, design: .monospaced))
                .shadow(color: .white, radius: 1)
                .contrast(2)
                
                Spacer()
                
                Text(gameResult.rawValue)
                    .font(.system(size: 50, weight: .semibold))
                    .fontDesign(.rounded)
                    .padding()
                
                Spacer()
                
                Text("Your Choice \(playerChoice.title)")
                    .font(.system(size: 20, weight: .heavy, design: .monospaced))
                    .shadow(color: .white, radius: 1)
                    .contrast(2)
                
                Text("You")
                    .bodyText()

                
                
                if gameState == .choosing {
                    loadChoiceButtons
                }
                else {
                    loadReplayButtons
                }
            }
        }
    }
    
    
    
    var loadChoiceButtons: some View {
        HStack{
            ForEach (Choices.allCases, id: \.self) { choice in
                
                Button{
                    let newComputerChoice = Choices.allCases
                        .randomElement()!
                    computerChoice = newComputerChoice
                    playerChoice = choice
                    
                    gameResult = choice.result(against: newComputerChoice)
                    updateScore(result: gameResult)
                    
                    gameState = .result
                } label: {
                    Text(choice.title)
                        .bodyText()
                        .background(.black,in: .capsule(style: .continuous))
                }
            }
        }
        .padding(.horizontal)
    }
    
    
    var loadReplayButtons: some View {
        HStack (alignment: .bottom){
            Button {
                reset()
            } label: {
                Image(
                    systemName: "arrow.trianglehead.counterclockwise"
                )
                .bodyText()
                .background(
                    .black,
                    in: .capsule(style: .continuous)
                )
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                gameState = .choosing
                gameResult = .waiting
                
            } label: {
                Text("Play Again")
                    .bodyText()
                    .background(
                        .black,
                        in: .capsule(style: .continuous)
                    )
            }
        }
        .padding(.horizontal)
    }
    
    
    
    func updateScore (result: GameResult) {
        switch result {
            case .win:     score.wins    += 1
            case .lose:    score.losses  += 1
            case .tie:     score.ties    += 1
            case .waiting: break
            }
    }
    func reset() {
        score.wins = 0
        score.losses = 0
        score.ties = 0
         
        gameState = .choosing
        gameResult = .waiting
    }
}
struct ScoreLabel: View {
    let title: String
    let value: Int
    
    var body: some View {
        VStack{
            Text("\(title):")
            Text("\(value)")
        }
        .bodyText()
        
    }
}

#Preview {
    ContentView()
}
