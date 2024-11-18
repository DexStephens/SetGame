//
//  SetGameView.swift
//  SetGame
//
//  Created by Dexter Stephens on 10/14/23.
//

import SwiftUI

struct SetGameView: View {
    let setGame: SetGameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LazyVGrid(columns: columns(for: geometry.size), spacing: Game.gridSpacing) {
                    ForEach(setGame.cardsInPlay) { card in
                        CardView(card: card)
                            .transition(AnyTransition.offset(randomOffScreenLocation))
                            .onTapGesture {
                                setGame.chooseCard(card)
                            }
                    }
                }
                Spacer()
                HStack {
                    Button("New Game") {
                        setGame.resetGame()
                    }
                    Spacer()
                    Button("Add 3 Cards") {
                        setGame.dealThreeCards()
                    }
                    .disabled(setGame.cardsLeft == 0)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Total Score: \(setGame.gameScore.formatted())")
                        Text("Total Sets: \(setGame.totalSets)")
                    }
                    
                }
            }
            .padding()
        }
        .onAppear {
            setGame.resetGame()
        }
    }
    
    private var randomOffScreenLocation: CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * Game.radiusMultiplier
        let factor: Double = Int.random(in: 0...1) > 0 ? 1 : -1
        return CGSize(width: factor * radius, height: factor * radius)
    }
    
    //MARK: - Helpers
    private func columns(for size: CGSize) -> [GridItem] {
        var columns: Double = Game.startColumns
        var requiredHeight: Double = 0
        
        repeat {
            columns += 1
            let spacingWidth = (columns - 1) * Game.gridSpacing
            let width = (size.width - spacingWidth) / columns
            let rows = ceil((Double(setGame.cardsInPlay.count) + columns - 1) / columns)
            
            let rowHeight = (width / Game.aspectRatio) * rows
            let rowSpacingHeight = (rows - 1) * Game.gridSpacing
            requiredHeight = rowHeight + rowSpacingHeight
        } while ( requiredHeight > size.height)
        
        return Array(repeating: GridItem(.flexible()), count: Int(columns))
    }
    
    //MARK: - Drawing Constants
    private struct Game {
        static let gridSpacing: CGFloat = 10
        static let aspectRatio: Double = 1.5
        static let startColumns: Double = 2
        static let radiusMultiplier = 1.5
    }
}

#Preview {
    SetGameView(setGame: SetGameViewModel())
}

//NEEDSWORK: return enum value for sound playing, closures, cardify, clean up code, add to github for resume, success on end of game play, possibly clean up the matching options
