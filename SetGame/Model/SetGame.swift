//
//  SetGame.swift
//  SetGame
//
//  Created by Dexter Stephens on 10/14/23.
//

import Foundation
import SwiftUI

struct SetGame {
    var undealtCards: [Card] = []
    var dealtCards: [Card] = []
    var setCount: Int = 0
    var totalScore: Double = 0

    //MARK: - Computed Properties
    var selectedCards: [Card] {
        dealtCards.filter { $0.status == .selected }
    }
    
    var matchedCards: [Card] {
        dealtCards.filter { $0.status == .matching}
    }
    
    var unmatchedCards: [Card] {
        dealtCards.filter { $0.status == .notMatching}
    }
    
    //MARK: - Game Logic
    mutating func resetGame() {
        undealtCards = []
        dealtCards = []
        setCount = 0
        totalScore = 0
        
        for quantity in CardQuantity.allCases {
            for shape in CardShape.allCases {
                for color in CardColor.allCases {
                    for fill in CardFill.allCases {
                        undealtCards.append(Card(shape: shape, quantity: quantity, color: color, fill: fill, status: .notSelected))
                    }
                }
            }
        }
        
        undealtCards.shuffle()
    }
    
    mutating func dealOneCard() -> Void {
        if undealtCards.count > 0 {
            if matchedCards.count == 3 {
                removeMatchedCards()
            }
            dealtCards.append(undealtCards.removeFirst())
        }
    }
    
    mutating func selectCard(_ card: Card) -> CardStatus {
        guard let dealtCardIndex = findDealtCardIndex(for: card) else {
            return .notSelected
        }
        
        if selectedCards.count == 2 && !selectedCards.hasCard(card) {
            dealtCards[dealtCardIndex].status = .selected
            
            if areCardsMatching() {
                setCount += 1
                addToScore()
                setSelectedCardsToMatching()
                
                return .matching
            } else {
                setSelectedCardsToNotMatching()
                return .notMatching
            }
        } else if matchedCards.count == 3 {
            removeMatchedCards()
                                
            if !selectedCards.hasCard(card) {
                if let dealtCardIndex = findDealtCardIndex(for: card) {
                    dealtCards[dealtCardIndex].status = .selected
                }
            }
        } else if unmatchedCards.count == 3 {
            deselectUnmatchedCards()
            
            dealtCards[dealtCardIndex].status = .selected
        } else {
            //no cards or one card selected, all we need to do is setCardSelection, depending on if it was already selected
            dealtCards[dealtCardIndex].status = dealtCards[dealtCardIndex].status == .notSelected ? .selected : .notSelected
        }
        
        //return this by default, we only actually care if it was matched or not matched
        return .selected
    }
    
    //MARK: - Private Helpers
    
    mutating func addToScore() -> Void {
        let totalCards = Double(dealtCards.count)
        
        let multiplier = ceil(81 / totalCards)
        
        totalScore = 3 * multiplier + totalScore
    }
    
    private func areCardsMatching() -> Bool {
        var matching = true
        
        let colors: [CardColor] = selectedCards.map { $0.color }
        
        if !allSameOrAllDifferent(for: colors) {
            matching = false
        }
        
        let fills: [CardFill] = selectedCards.map { $0.fill }
        
        if !allSameOrAllDifferent(for: fills) {
            matching = false
        }
        
        let shapes: [CardShape] = selectedCards.map { $0.shape }
        
        if !allSameOrAllDifferent(for: shapes) {
            matching = false
        }
        
        let quantities: [CardQuantity] = selectedCards.map { $0.quantity }
        
        if !allSameOrAllDifferent(for: quantities) {
            matching = false
        }
        
        return matching
    }
    
    private func allSameOrAllDifferent<T: Hashable>(for cardAttributes: [T]) -> Bool {
        var values = Set<T>()
        
        for attribute in cardAttributes {
            values.insert(attribute)
        }
        
        return values.count == 1 || values.count == cardAttributes.count
    }
    
    private mutating func deselectUnmatchedCards() {
        for card in unmatchedCards {
            if let index = findDealtCardIndex(for: card) {
                dealtCards[index].status = .notSelected
            }
        }
    }
    
    private mutating func setSelectedCardsToMatching() {
        for card in selectedCards {
            if let index = findDealtCardIndex(for: card) {
                dealtCards[index].status = .matching
            }
        }
    }
    
    private mutating func setSelectedCardsToNotMatching() {
        for card in selectedCards {
            if let index = findDealtCardIndex(for: card) {
                dealtCards[index].status = .notMatching
            }
        }
    }
    
    private mutating func removeMatchedCards() {
        var matchedCardIndexes: [Int] = []
        
        for card in matchedCards {
            if let index = findDealtCardIndex(for: card) {
                matchedCardIndexes.append(index)
            }
        }
        
        matchedCardIndexes.sort { $0 > $1 }
        
        for index in matchedCardIndexes {
            dealtCards.remove(at: index)
            if undealtCards.count > 0 {
                dealtCards.insert(undealtCards.removeFirst(), at: index)
            }
        }
    }
    
    private func findDealtCardIndex(for card: Card) -> Int? {
        for index in dealtCards.indices {
            if dealtCards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    //MARK: - Sub Structs
    
    struct Card: Identifiable {
        var id = UUID()
        var shape: CardShape
        var quantity: CardQuantity
        var color: CardColor
        var fill: CardFill
        var status: CardStatus
    }
}

//MARK: - Card Enums

enum CardShape: CaseIterable {
    case diamond, squiggle, oval
}

enum CardQuantity: Int, CaseIterable {
    case one = 1, two = 2, three = 3
}

enum CardColor: CaseIterable {
    case red, green, purple
}

enum CardFill: CaseIterable {
    case solid, striped, open
}

enum CardStatus {
    case matching, notMatching, selected, notSelected
}
