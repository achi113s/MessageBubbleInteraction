//
//  MessageReactionTypes.swift
//  MessageBubbles
//
//  Created by Giorgio Latour on 8/7/23.
//

import SwiftUI

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

