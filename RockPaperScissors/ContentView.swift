//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Павел Кай on 10.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var emoji = ["🪨", "📄", "✂️"].shuffled()
    
    
    var beatingFigures = { (figure: String, oposite: String) -> Bool in
        switch figure {
        case "🪨":
            return oposite != "📄"
        case "📄":
            return oposite != "✂️"
        case "✂️":
            return oposite != "🪨"
        default:
            return false
        }
    }
    
    @State private var shouldWin = Bool.random()
    @State private var appChoice = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var timePlay = 0
    @State private var showResult = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.yellow, .green], startPoint: .top, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                    Spacer()
                    Text("Score is \(score)")
                        .font(.largeTitle)
                    Spacer()
                }
                
                VStack {
                    Text(emoji[appChoice])
                        .font(.system(size: 65))
                    Text("You need to")
                    Text("\(shouldWin ? "Win" : "Lose")")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                }
                
                HStack(spacing: 30) {
                    ForEach(emoji, id: \.self) { figure in
                        Button {
                            emojiTapped(figure, shouldWin)
                        } label: {
                            Text(figure)
                                .font(.system(size: 65))
                                .padding()
                        }
                    }
                }
                
            }
            
        }
        .alert("Final result is \(score)", isPresented: $showResult) {
            Button("Reset game") {
                reset()
            }
        }
    }
    
    func emojiTapped(_ choice: String, _ shouldWin: Bool) {
        let result = beatingFigures(choice, emoji[appChoice])
        if (shouldWin == true && result || shouldWin == false && !result) && choice != emoji[appChoice]  {
            score += 1
        } else {
            score -= 1
        }
        
        timePlay += 1
        if timePlay == 10 {
            showResult.toggle()
        } else {
            newRound()
        }
    }
    
    func newRound() {
        appChoice = Int.random(in: 0...2)
        emoji.shuffle()
        shouldWin.toggle()
    }
    
    func reset() {
        timePlay = 0
        score = 0
        newRound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
