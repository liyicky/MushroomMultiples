//
//  LevelSlider.swift
//  MutiplicationPractice
//
//  Created by Jason Cheladyn on 2022/07/01.
//

import SwiftUI

struct LevelSlider: View {
    
    @EnvironmentObject var gameState: GameState
    
    let sliderPoints: Int
    @State var selectorPos: CGFloat
    @Binding var selection: Int
    
    static let sliderWidth = screenWidth*0.8
    
    /*
     Create an array of positions along the length of the slider.
     Tricky because half of the screen is in negative space.
     */
    var levels: [CGFloat] {
        var levels: [CGFloat] = []
        let half = LevelSlider.sliderWidth/2
        let halfPoints = CGFloat(sliderPoints/2)
        let halfPos = half / halfPoints
        
//        print("neg half")
        for index in (1...sliderPoints/2).reversed() {
            levels.append(-(halfPos) * CGFloat(index))
        }
        
//        print("pos half")
        for index in 0..<sliderPoints/2 {
            levels.append(halfPos * CGFloat(index))
        }
        return levels
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red.opacity(0.5), .red]), startPoint: .leading, endPoint: .trailing)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .frame(width: LevelSlider.sliderWidth, height: 30)
                .foregroundColor(.red)
            ZStack {
                Image("smallCard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text(String(selection))
                    .font(.system(size: 25))
                    .animation(.easeInOut, value: selection)
            }
            .offset(x: selectorPos)
            .gesture(
                DragGesture()
                    .onChanged {
                        handleSlide(slidePos: $0.translation.width)
                    }
            )
            .animation(.easeInOut, value: selectorPos)
        }
        .onAppear {
            selection = levels.count/2
        }
        .frame(width: LevelSlider.sliderWidth, height: 75)
    }
    
    func handleSlide(slidePos: CGFloat) {
        
        //binary search
        var lowIndex = 0
        var highIndex = levels.count - 1
        while lowIndex != highIndex {
            let midIndex = Int(floor(Double((lowIndex + highIndex) / 2)))
            
            if slidePos == levels[midIndex] {
                lowIndex = midIndex
                break
            }
            if slidePos > levels[midIndex] {
                lowIndex = midIndex+1
            }
            else {
                highIndex = midIndex
            }
        }
        selectorPos = levels[lowIndex]
        selection = lowIndex+1
    }
}

//struct LevelSlider_Previews: PreviewProvider {
//    static var previews: some View {
//        LevelSlider(sliderPoi)
//    }
//}
