//
//  SetGameTable.swift
//  TypeingA3
//
//  Created by Adelaide Jia on 2025/03/06.
//

import Foundation

class SetGameTable: ObservableObject {
    @Published private var game: SetGame
    private let initialNumber = 12
    @Published private(set) var presentNumber: Int
    
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
    
    func choose(_ card: SetGame.Card) {
        game.choose(card)
    }
    
    func newGame() {
        presentNumber = initialNumber
        game = SetGameTable.createSetGame()
        game.shuffle()
    }
    
    private static func createSetGame() -> SetGame {
        return SetGame()
    }
    
    var cards: Array<SetGame.Card> {
        if game.cards.count >= presentNumber {
            return Array(game.cards[0..<presentNumber])
        } else {
            return game.cards
        }
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
                print(presentNumber)
            }
        }
    }
}
