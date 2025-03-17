//
//  SetGame.swift
//  TypeingA3
//
//  Created by Adelaide Jia on 2025/03/06.
//

import SwiftUI

struct SetGame {
    private(set) var cards: Array<Card>
    private(set) var selectedCards: Array<Card> = []
    private(set) var setStatus = 1
    private(set) var discard: Array<Card> = []
    
    init() {
        cards = []
        var id = 0
        for shape in Content.Shape.allCases {
            for color in Content.ContentColor.allCases {
                for number in Content.NumberOfShape.allCases {
                    for shade in Content.Shading.allCases {
                        let content = Content(
                            shape: shape,
                            color: color,
                            number: number,
                            shade: shade
                        )
                        cards.append(Card(id: String(id), content: content))
                        id += 1
                    }
                }
            }
        }
    }
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if selectedCards.count == 3 {
                for selectedCard in selectedCards {
                    if cards[chosenIndex].id == selectedCard.id {
                        return
                    }
                }
                setSetStatus()
                threeCardsSelected()
            }
            if selectedCards.count <= 2 {
                if cards[chosenIndex].isSelected {
                    selectedCards.removeAll(where: { $0.id == cards[chosenIndex].id })
                } else {
                    selectedCards.append(cards[chosenIndex])
                }
            }
            cards[chosenIndex].isSelected.toggle()
            setSetStatus()
        }
    }
    
    private mutating func setSetStatus() {
        if selectedCards.count >= 3 {
            if checkCardMatching(cards: selectedCards) {
                setStatus = 2
            } else {
                setStatus = 3
            }
        } else {
            setStatus = 1
        }
    }
    
    private mutating func threeCardsSelected() {
        if checkCardMatching(cards: selectedCards) {
            removeMatchingSet()
        } else {
            let selectedIds = Set(selectedCards.map { $0.id })
            for index in cards.indices {
                if selectedIds.contains(cards[index].id) {
                    cards[index].isSelected = false
                }
            }
        }
        selectedCards = []
        setSetStatus()
    }
    
    mutating func removeMatchingSet() {
        if checkCardMatching(cards: selectedCards) {
            for selected in selectedCards {
                for (index, element) in cards.enumerated() {
                    if element.id == selected.id {
                        cards.remove(at: index)
                        discard.append(selected)
                    }
                }
            }
            selectedCards = []
            setSetStatus()
        }
    }
    
    
    
    private func checkCardMatching(cards: Array<Card>) -> Bool {
        return checkProperties(
            a: cards[0].content.number,
            b: cards[1].content.number,
            c: cards[2].content.number)
        && checkProperties(
            a: cards[0].content.shape,
            b: cards[1].content.shape,
            c: cards[2].content.shape)
        && checkProperties(
            a: cards[0].content.shade,
            b: cards[1].content.shade,
            c: cards[2].content.shade)
        && checkProperties(
            a: cards[0].content.color,
            b: cards[1].content.color,
            c: cards[2].content.color)
    }
    
    private func checkProperties<P: Equatable>(a: P, b: P, c: P) -> Bool {
        return ((a == b && b == c)) || ((a != b) && (b != c) && (a != c))
    }
    
    struct Card: Equatable, Identifiable {
        var id: String
        var content: Content
        var isSelected = false
    }
}
struct Content: Equatable {
    private(set) var shape: Shape
    private(set) var color: ContentColor
    private(set) var number: NumberOfShape
    private(set) var shade: Shading
    
    enum Shape: CaseIterable {
        case diamond, squiggle, oval
    }
    
    enum ContentColor: CaseIterable {
        case red, yellow, blue
    }
    
    enum NumberOfShape: CaseIterable {
        case one, two, three
    }
    
    enum Shading: CaseIterable {
        case solid, striped, open
    }
}

