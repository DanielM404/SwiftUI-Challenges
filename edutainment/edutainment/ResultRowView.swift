//
//  ResultRowView.swift
//  edutainment
//

import SwiftUI

struct ResultRowView: View {
    var question: String
    var answer: String
    var solved: Bool
    
    var body: some View {
        HStack {
            Text("\(question)")
                .padding(.leading, 25)
            Spacer()
            Text("\(answer)")
            Text(solved ? "😀" : "🥵")
                .padding(.leading, 50)
        }
        .padding(.vertical, 1)
    }
}

struct ResultRowView_Previews: PreviewProvider {
    static var previews: some View {
        ResultRowView(question: "3 x 7", answer: "21", solved: true)
            .previewLayout(.sizeThatFits)
        ResultRowView(question: "11 x 12", answer: "132", solved: false)
            .previewLayout(.sizeThatFits)
    }
}
