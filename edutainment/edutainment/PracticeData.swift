//
//  PracticeData.swift
//  edutainment
//

import SwiftUI

class PracticeData: ObservableObject {
    @Published var data: [(id: UUID, num1: Int, num2: Int, answer: Int, solved: Bool)] = [(UUID, Int, Int, Int, Bool)]()

#if DEBUG
    static let sampleData = [
        (3,3,9,false),
        (5,5,25,true),
        (7,7,49,false),
        (9,9,81,true)
    ]
#endif

#if DEBUG
    init() {
        PracticeData.sampleData.forEach { (num1: Int, num2: Int, answer: Int, solved: Bool) in
            addExerciseTuple(num1: num1, num2: num2, answer: answer, solved: solved)
        }
    }
#endif

    func clearData() {
        self.data.removeAll()
    }
    
    private func addExerciseTuple( num1: Int, num2: Int, answer: Int, solved: Bool ) {
        self.data.append( (UUID(), num1, num2, answer, solved) )
    }
    
    func generateExerciseData(number questions: Int, with range: [Int]) {
        guard range.count >= 5 else { return }

        data.removeAll()
        
        var tempData = [(left: Int, right: Int)]()
                
        let lefts = range.shuffled()
        let rights = range.shuffled()
        
        for right in rights {
        for left in lefts {
                tempData.append( (left: left, right: right) )
            }
        }
        
        tempData.shuffle()
        tempData.removeLast(tempData.count - questions)
        
        tempData.forEach { (left: Int, right: Int) in
            addExerciseTuple(num1: left, num2: right, answer: left * right, solved: false)
        }
        
    }

}

