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
    private var size: CGFloat
    private var description: MessageReactionType
    
    init(reactionType: MessageReactionType, size: CGFloat = 30) {
        self.symbol = reactionType.symbol
        self.color = reactionType.color
        self.size = size
        self.description = reactionType
    }
    
    var body: some View {
        Image(systemName: symbol)
            .foregroundColor(color)
            .font(.system(size: size))
    }
}

struct MessageReaction_Previews: PreviewProvider {
    static var previews: some View {
        MessageReaction(reactionType: .love, size: 30)
    }
}
