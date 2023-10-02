//
//  ContentView.swift
//  RPSTrainer
//
//  Created by Diego Martin on 10/2/23.
//

import SwiftUI

enum Choice: String, CaseIterable {
    case rock
    case paper
    case scissors
}

struct ContentView: View {
    @State private var computerChoice = Choice.allCases[Int.random(in: 0...2)]
    @State private var playerShouldWin = Bool.random()
    @State private var playerChoice = Choice.paper
    @State private var score = 0
    @State private var roundsRemaining = 10
    @State private var resultsText = "Confirm your choice to see if you win"
    @State private var computerChoiceHidden = true
    @State private var gameOverAlert = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Your score is \(score)")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            if !computerChoiceHidden {
                Text(emojiStyle(for: computerChoice))
                    .font(.system(size: 100))
            }
            
            Spacer()
            
            Text(playerShouldWin ? "Try to win" : "Try to lose")
                .font(.title)
            
            Spacer()
            
            Text(emojiStyle(for: playerChoice))
                .font(.system(size: 100))
            
            Picker("Choices: ", selection: $playerChoice) {
                ForEach(Choice.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Button(computerChoiceHidden ? "Confirm Choice" : "Reset") {
                if computerChoiceHidden {
                    computerChoiceHidden = false
                    resultsText = checkVictory() ? "Good!" : "Nice try"
                } else {
                    // reset game
                    setChoices()
                    roundsRemaining -= 1
                    if roundsRemaining == 0 {
                        gameOverAlert = true
                    }
                }
                
            }
            .buttonStyle(.borderedProminent)
            
            Text(resultsText)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            
        }
        .padding()
        .onAppear() {
            setChoices()
        }
        .alert("Your final score is \(score), good effort!", isPresented: $gameOverAlert) {
            Button("Reset") {
                resetScore()
                setChoices()
            }
        }
    }
    
    func setChoices() {
        computerChoiceHidden = true
        computerChoice = Choice.allCases[Int.random(in: 0...2)]
        playerShouldWin.toggle()
        playerChoice = .paper
    }
    
    func resetScore() {
        score = 0
        roundsRemaining = 10
    }
    
    func emojiStyle(for choice: Choice) -> String {
        switch(choice) {
        case .rock:
            "🪨"
        case .paper:
            "📜"
        case .scissors:
            "✂️"
        }
    }
    
    func checkVictory() -> Bool {
        var won = false
        
        // return false if tied, otherwise check who won the game, toggling if needed
        
        if computerChoice == .rock {
            if playerChoice == .rock {
                return false
            } else if playerChoice == .paper {
                won = true
            } else {
                //lose
            }
        } else if computerChoice == .paper {
            if playerChoice == .paper {
                return false
            } else if playerChoice == .scissors {
                won = true
            } else {
                //lose
            }
        } else {
            if playerChoice == .scissors {
                return false
            } else if playerChoice == .rock {
                won = true
            } else {
                //lose
            }
        }
        
        if (playerShouldWin && won) || (!playerShouldWin && !won) {
            score += 1
        }
        return (playerShouldWin ? won : !won)
    }
}



#Preview {
    ContentView()
}
