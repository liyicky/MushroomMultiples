//
//  Equation.swift
//  MutiplicationPractice
//
//  Created by Jason Cheladyn on 2022/07/06.
//

import SwiftUI

struct Equation: View {
    
    var leftInt: [Letter]
    var rightInt: [Letter]
    var size: CGFloat
    
    var body: some View {
        HStack {
            Word(letters: leftInt, width: size, height: size, spacing: 0)
            Image("times")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size/2)
            Word(letters: rightInt, width: size, height: size, spacing: 0)
        }
    }
}

//struct Equation_Previews: PreviewProvider {
//    static var previews: some View {
//        Equation(leftInt: "1337", rightInt: "8008", size: 40)
//    }
//}
