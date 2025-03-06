//
//  Squiggle.swift
//  TypeingA3
//
//  Created by Adelaide Jia on 2025/03/06.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let oneQuarterX = rect.minX + Constants.xOffsetRatio * rect.width
        let threeQuarterX = rect.minX + (1 - Constants.xOffsetRatio) * rect.width
        let oneQuarterY = rect.minY + Constants.yOffsetRatio * rect.height
        let threeQuarterY = rect.minY + (1 - Constants.yOffsetRatio) * rect.height
        
        return Path { p in
            p.move(to: CGPoint(x: rect.minX, y: oneQuarterY))
            p.addCurve(
                to: CGPoint(x: rect.maxX, y: threeQuarterY),
                control1: CGPoint(x: oneQuarterX, y: rect.maxY),
                control2: CGPoint(x: threeQuarterX, y: rect.midY)
            )
            p.addCurve(
                to: CGPoint(x: rect.minX, y: oneQuarterY),
                control1: CGPoint(x: threeQuarterX, y: rect.minY),
                control2: CGPoint(x: oneQuarterX, y: rect.midY)
            )
            p.closeSubpath()
        }
    }
    
    private struct Constants {
        static let xOffsetRatio = 0.35
        static let yOffsetRatio = 0.2
    }
}

#Preview {
    Squiggle().foregroundColor(.green)
}

