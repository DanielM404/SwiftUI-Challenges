//
//  ContentView.swift
//  edutainment
//

/*
 CHALLENGE DAY 35 : CONSOLIDATION III
 
 - the player needs to select which multiplication tables they want to practice.
   this could be pressing buttons, or it could be an "Up do..." stepper, going from 2 to 12.
 - the player should be able to select how many questions tehy want to be asked: 5, 10, or 20.
 - you should randomly generate as many questions as they asked for, whitin the difficulty range they asked for.
 */

import SwiftUI

struct ContentView: View {
    @StateObject var exercises = PracticeData()
    
    @State private var difficultyLevel = 0.0
    @State private var numOfQuestions = 5
    @State private var isPracticing = false
    @State private var showingPracticeSheet = false
    
    let difficulties = [
        0 : "beginner",
        1 : "easy",
        2 : "medium",
        3 : "intermediate",
        4 : "advanced",
        5 : "hard",
        6 : "expert"
    ]
    
    let abc: [String:[Int]] = [
        "beginner"      : [1,2,3,4,5],
        "easy"          : [2,3,4,5,6],
        "medium"        : [3,4,5,6,7],
        "intermediate"  : [3,4,5,6,7,8],
        "advanced"      : [4,5,6,7,8,9,10],
        "hard"          : [5,6,7,8,9,10,11],
        "expert"        : [6,7,8,9,10,11,12]
    ]
    
    var body: some View {
        VStack {
            
            GroupBox("Difficulty") {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(LinearGradient(gradient: Gradient(colors: [.green, .red]), startPoint: .leading, endPoint: .trailing))
                        .frame(height: 40)
                    Slider(value: $difficultyLevel, in: 0...6, step: 1)
                        .padding(10)
                }
                HStack {
                    Text("\(difficulties[Int(difficultyLevel)]!)")
                    Spacer()
                    Text("numbers : \(abc[(difficulties[Int(difficultyLevel)]!)]!.description)")
                }
            }
            
            GroupBox("How many questions to practice?") {
                Picker("", selection: $numOfQuestions) {
                    Text("5").tag(5)
                    Text("10").tag(10)
                    Text("20").tag(20)
                }
                .pickerStyle(.segmented)
            }
            
            GroupBox("Results") {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(exercises.data, id: \.id) { (_, num1, num2, answer, solved) in
                        ResultRowView(question: "\(num1) x \(num2)", answer: "\(answer)", solved: solved)
                            .padding(1)
                    }
                }
                .listStyle(.sidebar)
                .opacity(showingPracticeSheet ? 0 : 1)
                
            }
            .frame(height: 300, alignment: .top)
            
            Spacer()
            
            Button(action: {
                exercises.generateExerciseData(number: numOfQuestions, with: abc[(difficulties[Int(difficultyLevel)]!)]!)
                self.showingPracticeSheet = true
            }) {
                Image("pig")
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .shadow(radius: 5)
                    .padding(.vertical, 40)
            }.sheet(isPresented: self.$showingPracticeSheet) {
                PracticeView(exercises: exercises)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
