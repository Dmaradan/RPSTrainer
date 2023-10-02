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
    @State private var resultsText = "Confirm your choice to see if you win"
    
    var body: some View {
        VStack(spacing: 30) {
            Button("Print Computer Choice") {
                setChoices()
            }
            
            Text(emojiStyle())
                .font(.system(size: 200))
            Text(playerShouldWin ? "Try to win" : "Try to lose")
            
            Picker("Choices: ", selection: $playerChoice) {
                ForEach(Choice.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Button("Confirm Choice") {
                resultsText = checkVictory() ? "You won!" : "You lost"
            }
            .buttonStyle(.borderedProminent)
            
            Text(resultsText)
            
            
        }
        .padding()
    }
    
    func setChoices() {
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
        
        return (playerShouldWin ? won : !won)
    }
}



#Preview {
    ContentView()
}
