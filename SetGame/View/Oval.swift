//
//  Oval.swift
//  SetGame
//
//  Created by Dexter Stephens on 10/16/23.
//

import SwiftUI

struct TestingView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<1) { _ in
                    ZStack {
                        Oval()
                            .opacity(0.25)
                        Oval()
                            .stroke(lineWidth: 8)
                    }
                    .aspectRatio(1/2, contentMode: .fit)
                }
            }
            .foregroundStyle(.purple)
        }
        
    }
}

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        
        let radius: Double = min(rect.height, rect.width) / 2

        let topCenter = CGPoint(x: rect.midX, y: rect.minY + radius)

        let bottomCenter = CGPoint(x: rect.midX, y: rect.maxY - radius)

        let topLeft = CGPoint(x: rect.minX, y: rect.minY + radius)
        
        var path = Path()
        
        path.addArc(center: topCenter, radius: radius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addArc(center: bottomCenter, radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.addLine(to: topLeft)
        
        return path
    }
}

#Preview {
    TestingView()
}
