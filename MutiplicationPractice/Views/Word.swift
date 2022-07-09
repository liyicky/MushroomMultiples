//
//  Word.swift
//  MutiplicationPractice
//
//  Created by Jason Cheladyn on 2022/07/01.
//

import SwiftUI

struct Word: View {
    
    public let letters: [Letter]
    public let width: CGFloat
    public let height: CGFloat
    public let spacing: CGFloat
    
    var body: some View {
        HStack(spacing: spacing) {

            ForEach(letters) { letter in
                letter
            }
        }
        .frame(width: width, height: height, alignment: .center)
    }
}


struct Word_Previews: PreviewProvider {
    static var previews: some View {
        let letters: [Letter] = [
            Letter(character: "A"),
            Letter(character: "B"),
            Letter(character: "C"),
            Letter(character: "1"),
            Letter(character: "2"),
            Letter(character: "3")
        ]
        Word(letters: letters, width: 200, height: 100, spacing: -20)
    }
}

@available (macOS 10.15, * )
extension String {
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
}
