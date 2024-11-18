//
//  CardView.swift
//  SetGame
//
//  Created by Dexter Stephens on 10/14/23.
//

import SwiftUI

struct CardView: View {
    var card: SetGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10.0).fill(determineBackgroundColor(for: card))
                RoundedRectangle(cornerRadius: 10.0).stroke()
                HStack {
                    ForEach(0..<card.quantity.rawValue, id: \.self) {_ in
                        ZStack {
                            switch card.shape {
                                case .oval :
                                    Oval()
                                    .opacity(card.fill == .striped ? 0.25 : card.fill == .open ? 0 : 1)
                                    Oval()
                                    .stroke(lineWidth: 2)
                                case .diamond:
                                    Diamond()
                                    .opacity(card.fill == .striped ? 0.25 : card.fill == .open ? 0 : 1)
                                    Diamond()
                                    .stroke(lineWidth: 2)
                                case .squiggle:
                                    Squiggle()
                                    .opacity(card.fill == .striped ? 0.25 : card.fill == .open ? 0 : 1)
                                    Squiggle()
                                    .stroke(lineWidth: 2)
                            }
                        }
                        .foregroundStyle(determineShapeColor(for: card.color))
                        .aspectRatio(1/2, contentMode: .fit)
                    }
                }
                .padding(Constants.cardPadding)
            }
        }
        .aspectRatio(Constants.aspectRatio, contentMode: .fit)
    }
    
    //MARK: - Private Helpers
    private func determineShapeColor(for color: CardColor) -> Color {
        switch color {
            case .red:
                return Color.red
            case .green:
                return Color.green
            case .purple:
                return Color.purple
        }
    }
    
    private func determineBackgroundColor(for card: SetGame.Card) -> Color {
        switch card.status {
            case .matching:
                return Constants.backgroundGreen
            case .notMatching:
                return Constants.backgroundRed
            case .notSelected:
                return .white
            case .selected:
                return .yellow
        }
    }
    
    //MARK: - Drawing Constants
    private struct Constants {
        static let cardPadding: Double = 8
        static let aspectRatio: Double = 3/2
        static let shapePadding = 5
        static let backgroundRed = Color(red: 1.0, green: 0.6, blue: 0.6)
        static let backgroundGreen = Color(red: 0.6, green: 1.0, blue: 0.6)
    }
}

#Preview {
    CardView(card: SetGame.Card(shape: .oval, quantity: .three, color: .green, fill: .open, status: .selected))
}
