//
//  ContentView.swift
//  MessageBubbles
//
//  Created by Giorgio Latour on 7/26/23.
//

import SwiftUI

struct ContentView: View {
    let message: String = "I need an iPod classic with Bluetooth capability."
    let user: String = "Johnny"
    
    let message2: String = "Yeah!"
    let user2: String = "Billy"
    
    var body: some View {
        VStack {
            Message(message: message, user: user)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
