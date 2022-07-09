//
//  MainMenuView.swift
//  MutiplicationPractice
//
//  Created by Jason Cheladyn on 2022/07/01.
//

import SwiftUI

struct MainMenuView: View {
    
    @EnvironmentObject var gameState: GameState
    
    var body: some View {
        ZStack {            
            VStack(spacing: -20) {
                Word(letters: "Mushroom".letters(), width: 300, height: 100, spacing: -20)
                Word(letters: "Multiples".letters(), width: 400, height: 100, spacing: -20)
                Spacer()
                
                Word(letters: "Times Table".letters(), width: 300, height: 35, spacing: 0)
                LevelSlider(sliderPoints: 12, selectorPos: 0, selection: $gameState.level)
                Word(letters: "Amount of problems".letters(), width: 300, height: 35, spacing: 0)
                LevelSlider(sliderPoints: 50, selectorPos: 0, selection: $gameState.questionAmount)
                
                Spacer()
                Button {
                    gameState.gameStarted = true
                } label: {
                    ZStack {
                        Image("smallCard")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .shadow(color: .black, radius: 5, x: 0, y: 5)
                        Word(letters: "Play".letters(), width: 300, height: 100, spacing: -30)
                    }
                }

            }
            
            
        }
        
    }
}

struct MainMenuView_Previews: PreviewProvider {
    
    @State static var gameStarted = false
    
    static var previews: some View {
        MainMenuView()
    }
}
