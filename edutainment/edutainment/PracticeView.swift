//
//  PracticeView.swift
//  edutainment
//

import SwiftUI

struct PracticeView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var exercises: PracticeData
    
    @State private var currentQuestion = 1
    @State private var inputAnswer = ""
    @State private var inputGiven = false
    @State private var isCorrectAnswer = false
    
    var lastQuestionReached: Bool {
        inputAnswer.count > 2
    }
        
    var body: some View {
        
        ZStack {
            NavigationView {
                VStack(spacing: 10) {
                    GroupBox("Your challenge to solve") {
                        let num1 = exercises.data[currentQuestion-1].num1
                        let num2 = exercises.data[currentQuestion-1].num2
                        let solved = exercises.data[currentQuestion-1].solved
                        HStack {
                            Spacer()
                            Text("\(num1) x \(num2)")
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                                .shadow(radius: 5)
                            Spacer()
                            Text("\(solved ? "😀" : "?")")
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                                .shadow(radius: 5)
                            Spacer()
                        }.padding(1)
                    }
                    
                    GroupBox("Enter your result here : \(inputAnswer)") {
                        GeometryReader{ r in
                            VStack {
                                HStack {
                                    Button(action: {
                                        inputAnswer += "7"
                                    }) {
                                        Text("7")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .background(Color.teal)
                                    }.disabled(lastQuestionReached)
                                    Button(action: {
                                        inputAnswer += "8"
                                    }) {
                                        Text("8")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .background(Color.teal)
                                    }.disabled(lastQuestionReached)
                                    Button(action: {
                                        inputAnswer += "9"
                                    }) {
                                        Text("9")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .background(Color.teal)
                                    }.disabled(lastQuestionReached)
                                }
                                HStack {
                                    Button(action: {
                                        inputAnswer += "4"
                                    }) {
                                        Text("4")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .background(Color.teal)
                                    }.disabled(lastQuestionReached)
                                    Button(action: {
                                        inputAnswer += "5"
                                    }) {
                                        Text("5")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .background(Color.teal)
                                    }.disabled(lastQuestionReached)
                                    Button(action: {
                                        inputAnswer += "6"
                                    }) {
                                        Text("6")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .background(Color.teal)
                                    }.disabled(lastQuestionReached)
                                }
                                HStack {
                                    Button(action: {
                                        inputAnswer += "1"
                                    }) {
                                        Text("1")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .background(Color.teal)
                                    }.disabled(lastQuestionReached)
                                    Button(action: {
                                        inputAnswer += "2"
                                    }) {
                                        Text("2")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .background(Color.teal)
                                    }.disabled(lastQuestionReached)
                                    Button(action: {
                                        inputAnswer += "3"
                                    }) {
                                        Text("3")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .background(Color.teal)
                                    }.disabled(lastQuestionReached)
                                }
                                HStack {
                                    Button(action: {
                                        inputAnswer += "0"
                                    }) {
                                        Text("0")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .background(Color.teal)
                                    }.disabled(lastQuestionReached)
                                    Button(action: {
                                        inputAnswer = ""
                                    }) {
                                        Text("CLR")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .border(Color.gray, width: 2)
                                            .shadow(radius: 2)
                                    }
                                    Button(action: {
                                        checkCorrectAnswerAndUpdateTuple()
                                    }) {
                                        Text("ENT")
                                            .font(.largeTitle)
                                            .frame(width: 110, height: 80, alignment: .center)
                                            .border(Color.gray, width: 2)
                                            .shadow(radius: 2)
                                    }
                                }
                            }.overlay {
                                if exercises.data[currentQuestion-1].solved {
                                    ZStack {
                                        Text("SOLVED")
                                            .font(.custom("Chalkduster", size: 48))
                                            .fontWeight(.heavy)
                                            .foregroundColor(.red)
                                            .shadow(radius: 12)
                                    }
                                    .frame(width: r.size.width + 10, height: r.size.height)
                                    .background(.brown)
                                    .opacity(0.8)
                                    .cornerRadius(10)
                                }
                            }
                        }.padding(5)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "pip.exit")
                                .font(.largeTitle)
                                .offset(x: -10, y: 0)
                        }
                        Spacer()
                    }
                }
                .navigationBarTitle("Multiplications")
                .navigationBarItems(
                    leading:
                        Button(action: {
                            inputAnswer = ""
                            currentQuestion -= 1
                        }) {
                            Image(systemName: "chevron.left.2")
                        }.disabled(currentQuestion < 2),
                    
                    trailing:
                        Button(action: {
                            inputAnswer = ""
                            currentQuestion += 1
                        }) {
                            Image(systemName: "chevron.right.2")
                        }.disabled(currentQuestion >= exercises.data.count)
                )
            }
        }
        .interactiveDismissDisabled()

    }
    
    func checkCorrectAnswerAndUpdateTuple() {
        isCorrectAnswer = Int(inputAnswer) == exercises.data[currentQuestion-1].answer
        if isCorrectAnswer {
            exercises.data[currentQuestion-1].solved = true
        }
        isCorrectAnswer = false
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView(exercises: PracticeData())
            .previewDevice("iPhone 12 Pro")
    }
}
