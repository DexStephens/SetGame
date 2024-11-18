//
//  Array+Card.swift
//  SetGame
//
//  Created by Dexter Stephens on 10/24/23.
//

import Foundation

extension Array where Element == SetGame.Card {
    func hasCard(_ incomingCard: SetGame.Card) -> Bool {
        var hasCard = false
        
        self.forEach { card in
            if card.id == incomingCard.id {
                hasCard = true
            }
        }
        
        return hasCard
    }
}
