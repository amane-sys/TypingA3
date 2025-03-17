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
                deck
                Spacer()
                Button("New Game") {
                    setGameTable.newGame()
                }
                Spacer()
                discard
                Spacer()
            }
            .font(.headline)
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(setGameTable.cards, aspectRatio: aspectRatio) { card in
            Group {
                if setGameTable.isDealt(card) {
                    CardView(card: card, setGameTable: setGameTable)
                        .padding(5)
                        .matchedGeometryEffect(id: card.id, in: dealingCards)
                        .onTapGesture {
                            setGameTable.choose(card)
                        }
                        .matchedGeometryEffect(id: card.id, in: discardCards)
                        .transition(
                            .asymmetric(insertion: .identity, removal: .identity)
                        )
                }
            }
        }
    }
    
    @Namespace private var dealingCards
    @Namespace private var discardCards
    
    private var deck: some View {
        VStack {
            ZStack {
                ForEach(setGameTable.undealtCards) { card in
                    CardView(card: card, setGameTable: setGameTable)
                        .matchedGeometryEffect(id: card.id, in: dealingCards)
                        .transition(
                            .asymmetric(insertion: .identity, removal: .identity)
                        )
                }
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(.blue)
                        Text("\(setGameTable.undealtCards.count)")
                            .font(.title)
                            .foregroundColor(.white)
                            .animation(.default)
                    }
                )
                .frame(width: deckWidth, height: deckWidth / aspectRatio)
                .onTapGesture {
                    if setGameTable.dealt.count == 0 {
                        deal()
                    } else {
                        setGameTable.dealThreeMoreCards()
                    } 
                }
            }
            Text("Deck")
        }

    }
    private let deckWidth: CGFloat = 70
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in setGameTable.cards {
            withAnimation(.easeIn(duration: 1).delay(delay)) {
                _ = setGameTable.dealt.insert(card.id)
            }
            delay += 0.1
        }
            
    }

    private var discard: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10).opacity(0)
                    .frame(width: deckWidth, height: deckWidth / aspectRatio)
                ForEach(setGameTable.discard, id: \.id) { card in
                        CardView(card: card, setGameTable: setGameTable)
                            .matchedGeometryEffect(id: card.id, in: discardCards)
                            .transition(
                                .asymmetric(insertion: .identity, removal: .identity)
                            )
                }
                .frame(width: deckWidth, height: deckWidth / aspectRatio)
            }
            
            Text("Discard")
        }
    }
}

#Preview {
    SetGameView(setGameTable: SetGameTable())
}
