//
//  ContentView.swift
//  TypeingA3
//
//  Created by Adelaide Jia on 2025/03/06.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGameTable: SetGameTable
    private let aspectRatio: CGFloat = 0.75
    
    var body: some View {
        VStack {
            cards
            HStack {
                Spacer()
                Button("New Game") {
                    setGameTable.newGame()
                }
                Spacer()
                if setGameTable
                    .getTotalCardsCount() - setGameTable.presentNumber - 1 > 0 {
                    Button("Deal 3 More Cards"){
                        setGameTable.dealThreeMoreCards()
                    }
                }
                
                Spacer()
            }
            .font(.headline)
            
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(setGameTable.cards, aspectRatio: aspectRatio) { card in
            CardView(card: card, setGameTable: setGameTable)
                .padding(5)
                .onTapGesture {
                    setGameTable.choose(card)
                }
        }
    }
}

#Preview {
    SetGameView(setGameTable: SetGameTable())
}
