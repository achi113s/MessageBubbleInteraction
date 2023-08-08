//
//  ContentView.swift
//  MessageBubbles
//
//  Created by Giorgio Latour on 7/26/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var message1: MessageData = MessageData(
        user: "Giorgio",
        messageText: "I've been studying iOS development for 5 months now! 🤩",
        reactions: []
    )
    
    var body: some View {
        VStack {
            MessageBubble(message1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
