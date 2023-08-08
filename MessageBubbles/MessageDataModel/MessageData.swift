//
//  MessageData.swift
//  MessageBubbles
//
//  Created by Giorgio Latour on 8/7/23.
//

import SwiftUI

class MessageData: ObservableObject {
    let user: String
    let messageText: String
    
    @Published var reactions: [MessageReactionType]
    
    init(user: String, messageText: String, reactions: [MessageReactionType]) {
        self.user = user
        self.messageText = messageText
        self.reactions = reactions
    }
    
    func addReaction(_ reaction: MessageReactionType) {
        reactions.append(reaction)
    }
}
