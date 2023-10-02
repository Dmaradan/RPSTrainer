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
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Your score is \(score)")
            Text("\(roundsRemaining) rounds remaining")
            
            if !computerChoiceHidden {
                Text(emojiStyle())
                    .font(.system(size: 200))
            }
            
            Text(playerShouldWin ? "Try to win" : "Try to lose")
            
            Picker("Choices: ", selection: $playerChoice) {
                ForEach(Choice.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Button(computerChoiceHidden ? "Confirm Choice" : "Reset") {
                if computerChoiceHidden {
                    computerChoiceHidden = false
                    resultsText = checkVictory() ? "You won!" : "You lost"
                } else {
                    // reset game
                    setChoices()
                    roundsRemaining -= 1
                }
                
            }
            .buttonStyle(.borderedProminent)
            
            Text(resultsText)
            
            
        }
        .padding()
        .onAppear() {
            setChoices()
        }
    }
    
    func setChoices() {
        computerChoiceHidden = true
        computerChoice = Choice.allCases[Int.random(in: 0...2)]
        playerShouldWin.toggle()
    }
    
    func emojiStyle() -> String {
        switch(computerChoice) {
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
