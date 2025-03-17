//
//  SetGameTable.swift
//  TypeingA3
//
//  Created by Adelaide Jia on 2025/03/06.
//

import Foundation
import SwiftUI

class SetGameTable: ObservableObject {
    @Published private var game: SetGame
    private let initialNumber = 9
    @Published private(set) var presentNumber: Int
    typealias Card = SetGame.Card
    
    init() {
        presentNumber = initialNumber
        game = SetGameTable.createSetGame()
        game.shuffle()
    }
    
    func getSetStatus() -> Int {
        return game.setStatus
    }
    
    func shuffle() {
        game.shuffle()
    }
    
    func choose(_ card: Card) {
        game.choose(card)
    }
    
    func newGame() {
        presentNumber = initialNumber
        game = SetGameTable.createSetGame()
        game.shuffle()
        dealt.removeAll()
    }
    
    private static func createSetGame() -> SetGame {
        return SetGame()
    }
    
    var cards: Array<Card> {
        //return Array(game.cards[0..<initialNumber])
        if game.cards.count >= presentNumber {
            return Array(game.cards[0..<presentNumber])
        } else {
            return game.cards
        }
    }
    var discard: Array<Card> {
        return game.discard
    }
    
    func discard3() {
        game.removeMatchingSet()
    }
    
    @Published var dealt = Set<Card.ID>()
    // var deckCount = game.cards.count - dealt.count
    @Published var discards = Set<Card.ID>()
    
    func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    func isDiscarded(_ card: Card) -> Bool {
        discard.contains(card)
    }
    
    var undealtCards: [Card] {
        game.cards.filter { !isDealt($0) }
    }
    
    var undiscardedCards: [Card] {
        game.cards.filter { isDiscarded($0) }
    }
    
    func getTotalCardsCount() -> Int {
        return game.cards.count
    }
    
    func dealThreeMoreCards() {
        if getSetStatus() == 2 {
            game.removeMatchingSet()
        } else {
            if presentNumber <= game.cards.count - 3 { //
                presentNumber += 3
                var delay: TimeInterval = 0
                for card in cards.suffix(3) {
                    withAnimation(.easeIn(duration: 1).delay(delay)) {
                      _ = dealt.insert(card.id)
                    }
                    delay += 0.1
                }
            }
        }
    }
    func deal3() {
        if presentNumber <= game.cards.count - 3 { //
            presentNumber += 3
            var delay: TimeInterval = 0
            for card in cards {
                withAnimation(.easeIn(duration: 1).delay(delay)) {
                    _ = dealt.insert(card.id)
                }
                delay += 0.1
            }
            print(presentNumber)
        }

        
    }
}
