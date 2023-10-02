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
    @State private var computerChoice: Choice = .rock
    @State private var playerShouldWin: Bool = true
    
    
    var body: some View {
        VStack {
            Button("Print Computer Choice") {
                selectComputerChoice()
            }
            
            Text(computerChoice.rawValue)
        }
        .padding()
    }
    
    func selectComputerChoice() {
        computerChoice = Choice.allCases[Int.random(in: 0...2)]
    }
}



#Preview {
    ContentView()
}
