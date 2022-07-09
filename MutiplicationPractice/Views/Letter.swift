//
//  Letter.swift
//  MutiplicationPractice
//
//  Created by Jason Cheladyn on 2022/07/01.
//

import SwiftUI

struct Letter: View, Identifiable {
    let character: String
    let id = UUID()
    
    var body: some View {
        Image(character)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct Letter_Previews: PreviewProvider {
    static var previews: some View {
        Letter(character: "A")
    }
}
