//
//  MessageReaction.swift
//  MessageBubbles
//
//  Created by Giorgio Latour on 7/26/23.
//

import SwiftUI

struct MessageReaction: View {
    private var symbol: String
    private var color: Color
    private var size: CGFloat = 30
    private var description: MessageReactionType
    
    init(symbol: String, color: Color, size: CGFloat, description: MessageReactionType) {
        self.symbol = symbol
        self.color = color
        self.size = size
        self.description = description
    }
    
    var body: some View {
        Image(systemName: symbol)
            .foregroundColor(color)
            .font(.system(size: size))
    }
}

struct MessageReaction_Previews: PreviewProvider {
    static let symbol: String = "heart.fill"
    static let color: Color = .pink
    static let size: CGFloat = 30
    static let description: MessageReactionType = .love
    
    static var previews: some View {
        MessageReaction(symbol: symbol, color: color, size: size, description: description)
    }
}

enum MessageReactionType: String {
    case reply
    case love
    case dislike
    case shareTo
    
    var description: String {
        switch self {
        case .reply:
            return "reply"
        case .love:
            return "love"
        case .dislike:
            return "dislike"
        case .shareTo:
            return "share"
        }
    }
    
    var symbol: String {
        switch self {
        case .reply:
            return "arrowshape.turn.up.left.circle.fill"
        case .love:
            return "heart.fill"
        case .dislike:
            return "hand.thumbsdown.fill"
        case .shareTo:
            return "arrow.uturn.forward"
        }
    }
    
    var color: Color {
        switch self {
        case .reply:
            return .blue
        case .love:
            return .pink
        case .dislike:
            return .purple
        case .shareTo:
            return .green
        }
    }
}
