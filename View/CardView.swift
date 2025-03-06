//
//  CardView.swift
//  TypeingA3
//
//  Created by Adelaide Jia on 2025/03/06.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card //  .Card in every file
    @ObservedObject var setGameTable: SetGameTable
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                
                if card.isSelected {
                    if setGameTable.getSetStatus() == 2 {
                        base.strokeBorder(Color.green, lineWidth: 3)
                    } else if setGameTable.getSetStatus() == 3 {
                        base.strokeBorder(Color.red, lineWidth: 3)
                    } else {
                        base.strokeBorder(Color.mint, lineWidth: 3)
                    }
                    
                } else {
                    base.strokeBorder(Color.gray.opacity(0.7), lineWidth: 2)
                }
                
                switch card.content.shape {
                case .diamond:
                    stackShape(applyShading(to: Diamond()))
                case .squiggle:
                    stackShape(applyShading(to: Squiggle()))
                case .oval:
                    stackShape(
                        applyShading(to: RoundedRectangle(cornerRadius: 20))
                    )
                }
            }
        }
    }
    
    func stackShape(_ shape: some View) -> some View {
        VStack {
            switch card.content.number {
            case .one:
                shape
            case .two:
                shape
                shape
            default:
                shape
                shape
                shape
            }
        }
        .padding(10)
    }
    
    @ViewBuilder
    func applyShading(to shape: some Shape) -> some View {
        switch card.content.shade {
        case .solid:
            shape
                .fill(card.content.color)
                .minimumScaleFactor(0.1)
                .aspectRatio(2, contentMode: .fit)
        case .striped:
            shape
                .foregroundColor(card.content.color.opacity(0.5))
                .overlay(shape.stroke(card.content.color, lineWidth: 3))
                .minimumScaleFactor(0.1)
                .aspectRatio(2, contentMode: .fit)
        case .open:
            shape
                .stroke(card.content.color, lineWidth: 3)
                .foregroundColor(.white)
                .aspectRatio(2, contentMode: .fit)
        }
    }
}

#Preview {
    CardView(
        card: SetGame
            .Card(
                id: String(0),
                content: Content(
                    shape: Content.Shape.diamond,
                    color: .blue,
                    number: Content.NumberOfShape.three,
                    shade: Content.Shading.striped
                )
            ),
        setGameTable: SetGameTable()
    )
}
