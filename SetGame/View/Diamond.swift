//
//  Diamond.swift
//  SetGame
//
//  Created by Dexter Stephens on 10/15/23.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<1) { _ in
                    ZStack {
                        Diamond()
                            .opacity(0.25)
                        Diamond()
                            .stroke(lineWidth: 8)
                    }
                    .aspectRatio(1/2, contentMode: .fit)
                }
            }
            .frame(height: geometry.size.width / 2)
            .rotationEffect(Angle(degrees: 90))
            .foregroundStyle(.purple)
        }
        
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let leftPoint = CGPoint(x: rect.minX, y: center.y)
        let bottomPoint = CGPoint(x: center.x, y: rect.maxY)
        let rightPoint = CGPoint(x: rect.maxX, y: center.y)
        let topPoint = CGPoint(x: center.x, y: rect.minY)
        
        var path = Path()
        
        path.move(to: leftPoint)
        
        path.addLine(to: topPoint)
        
        path.addLine(to: rightPoint)
        
        path.addLine(to: bottomPoint)
        
        path.addLine(to: leftPoint)
        
        return path
    }
}

#Preview {
    TestView()
}
