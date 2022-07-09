//
//  ContentView.swift
//  MutiplicationPractice
//
//  Created by Jason Cheladyn on 2022/07/01.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var gameState = GameState.instance
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            if !gameState.gameStarted {
                MainMenuView()
            } else {
                PlayView()
            }
        }
        .animation(.easeInOut, value: gameState.gameStarted)
        .environmentObject(gameState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class GameState: ObservableObject {
    
    static var instance = GameState()
    
    @Published var gameStarted = false
    @Published var level = 7
    @Published var questionAmount = 0
}

extension String {
    func letters() -> [Letter] {
        var letters: [Letter] = []
        for char in self {
            letters.append(Letter(character: String(char).uppercased()))
        }
        return letters
    }
}


// MARK: - GLOBALS
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
