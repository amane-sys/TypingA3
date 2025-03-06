//
//  Diamond.swift
//  TypeingA3
//
//  Created by Adelaide Jia on 2025/03/06.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    Diamond()
        .stroke(.blue, lineWidth: 3)
        .fill(.blue.opacity(0.5))
        .minimumScaleFactor(0.1)
        .aspectRatio(2, contentMode: .fit)
}
