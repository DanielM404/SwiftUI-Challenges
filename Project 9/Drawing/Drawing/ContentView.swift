//
//  ContentView.swift
//  Drawing
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var startPoint: UnitPoint
    var endPoint: UnitPoint
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: startPoint, //.leading,
                            endPoint: endPoint // .trailing
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
        // use only when performance in drawing is an issue
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return (Color(hue: targetHue, saturation: 1, brightness: brightness))
    }
}

struct ContentView: View {
    @State private var colorCycle = 0.0
    @State var tap = 0
    @State var lastClick = CGPoint.zero
    @State private var startPoint: UnitPoint = UnitPoint(x: 0.5, y: 0)
    @State private var endPoint: UnitPoint = UnitPoint(x: 0.5, y: 1)
    
    var body: some View {
        VStack {
            Text("origin for gradient: (x: \(startPoint.x, specifier: "%.02f"), y: \(startPoint.y, specifier: "%.02f")")
            
            ColorCyclingRectangle(amount: colorCycle, startPoint: startPoint, endPoint: endPoint)
                .frame(width: 300, height: 300)
                .gesture(DragGesture(minimumDistance: 0)
                    .onEnded() { value in
                        self.lastClick = value.startLocation
                        startPoint = UnitPoint(x: (1 / 300) * value.location.x, y: (1 / 300) * value.location.y)
                        endPoint = UnitPoint(x: 1 - startPoint.x, y: 1 - startPoint.y)
                    }
                )
            Slider(value: $colorCycle)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
