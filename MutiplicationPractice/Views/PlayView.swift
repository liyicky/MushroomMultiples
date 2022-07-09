//
//  PlayView.swift
//  MutiplicationPractice
//
//  Created by Jason Cheladyn on 2022/07/04.
//

import SwiftUI

struct PlayView: View {
    
    @StateObject var vm = PlayViewModel()
    
    var body: some View {
        
        VStack {
            HStack {
                ForEach(0..<vm.gameState.questionAmount) {_ in
                    Image("butterfly")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 5)
                }
            }
            
            Spacer()
            ZStack {
                
                ZStack {
                    Image("largeCard")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotationEffect(Angle(degrees: 90))
                        .frame(height: 400)
                        .offset(y: 100)

                    Equation(leftInt: vm.leftIntLetters, rightInt: vm.rightIntLetters, size: 50)
                        .offset(y: 100)

                
                }
                if vm.correctAnswer {
                    Image("happyElf")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400)
                        .offset(y: vm.correctAnswerAni)
                        .transition(AnyTransition.opacity.combined(with: .slide))
                    
                } else {
                    Image("sadElf")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400)
                        .offset(y: -160)
                        .transition(AnyTransition.opacity.combined(with: .slide))
                }
            }
            
            Spacer()
            
            HStack {
                TextField("Answer", text: $vm.answer)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
                    .frame(width: screenWidth * 0.45)
                    .keyboardType(.decimalPad)
                    
                
                Button {
                    vm.submit()
                } label: {
                    Text("Submit")
                        .foregroundColor(.white)
                        .frame(width: screenWidth * 0.45, height: 55)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .disabled(vm.answer == "")
            }

            
            
            HStack {
                Word(letters: String(vm.correctAnswerCount).letters(), width: 100, height: 100, spacing: 0)
                Text("/")
                    .font(.system(size: 50))
                Word(letters: String(vm.gameState.questionAmount).letters(), width: 120, height: 120, spacing: 0)
            }

        }
        .onAppear { vm.generateQuestions() }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }
    
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}

class PlayViewModel: ObservableObject {
        
    public var gameState = GameState.instance
    
    @Published var happyState = false
    @Published var answer = ""
    @Published var leftInt = "1337"
    @Published var rightInt = "8008132"
    @Published var leftIntLetters: [Letter] = []
    @Published var rightIntLetters: [Letter] = []
    @Published var correctAnswer: Bool = true
    @Published var correctAnswerAni: CGFloat = -160
    @Published var correctAnswerCount = 0
    @Published var questionsAnsweredCount = 0
    
    private var currentIntergers: (Int, Int) {
        return (questions[questionIndex].0, questions[questionIndex].1)
    }
    
    private var questions: [(Int, Int)] = []
    private var questionIndex = 0
    
    func generateQuestions() {
        
        for _ in 1...gameState.questionAmount {
            let intOne = Int.random(in: 0...gameState.level)
            let intTwo = Int.random(in: 0...gameState.level)
            questions.append((intOne, intTwo))
            leftInt = String(questions[questionIndex].0)
            rightInt = String(questions[questionIndex].1)
        }
        setLetters()
    }
    
    func submit() {
        questionsAnsweredCount += 1
        if questionsAnsweredCount == gameState.questionAmount {
            gameState.gameStarted = false
            return
        }
        
        if correctAnswer {
            withAnimation(.interpolatingSpring(stiffness: 500, damping: 50)) {
                correctAnswerAni = -140
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut) {
                    self.correctAnswerAni = -160
                }
            }
            correctAnswerCount += 1
        }
        
        let answer = String(currentIntergers.0 * currentIntergers.1)
        questionIndex += 1
        leftInt = String(questions[questionIndex].0)
        rightInt = String(questions[questionIndex].1)
        setLetters()
        
        withAnimation {
            correctAnswer = self.answer == answer
            self.answer = ""
        }
        
    }
    
    func setLetters() {
        leftIntLetters = []
        for char in leftInt {
            leftIntLetters.append(Letter(character: String(char)))
        }
        rightIntLetters = []
        for char in rightInt {
            rightIntLetters.append(Letter(character: String(char)))
        }

    }
}
