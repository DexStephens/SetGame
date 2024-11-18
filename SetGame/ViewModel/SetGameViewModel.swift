//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Dexter Stephens on 10/14/23.
//

import Foundation
import SwiftUI

@Observable class SetGameViewModel {
    //MARK: - Properties
    private var game = SetGame()
    
    private var soundPlayer = SoundPlayer()
    
    //MARK: - Model Access
    var cardsInPlay: [SetGame.Card] {
        game.dealtCards
    }
    
    var totalSets: Int {
        game.setCount
    }
    
    var gameScore: Double {
        game.totalScore
    }
    
    var cardsLeft: Int {
        game.undealtCards.count
    }
    
    //MARK: - User Intents
    func chooseCard(_ card: SetGame.Card) {
        withAnimation(.easeInOut(duration: Constants.enterDuration)) {
            let selectResult = game.selectCard(card)
            
            if selectResult == .matching {
                soundPlayer.playSound(named: "successfulMatch.m4a")
            } else if selectResult == .notMatching {
                soundPlayer.playSound(named: "errorMatch.m4a")
            }
        }
    }
    
    func resetGame() {
        withAnimation(.easeInOut(duration: Constants.exitDuration)) {
            game.resetGame()
        }
        startGame()
    }
    
    func dealThreeCards() {
        for index in 0..<3 {
            withAnimation(.easeInOut(duration: Constants.enterDuration).delay(Constants.enterDuration * Double(index))) {
                game.dealOneCard()
            }
        }
    }
    
    //MARK: - Private Helpers
    private func startGame() {
        for index in 0..<12 {
            withAnimation(.easeInOut(duration: Constants.enterDuration).delay(Constants.enterDuration * Double(index))) {
                game.dealOneCard()
            }
        }
    }
    
    //MARK: - Constants
    private struct Constants {
        static let exitDuration = 0.5
        static let enterDuration = 0.35
        static let totalCards = 81
    }
}
