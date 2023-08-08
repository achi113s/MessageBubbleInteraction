//
//  MessageBlock.swift
//  MessageBubbles
//
//  Created by Giorgio Latour on 7/26/23.
//

import SwiftUI

struct MessageBlock: View {
    var messageText: String
    var userName: String
    
    var body: some View {
        VStack {
            Text("**\(userName)** \(messageText)")
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(
                            Gradient(colors: [
                                Color.white,
                                Color.init(white: 0.95)
                            ])
                        )
                )
                .overlay(
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 15).stroke(style: .init(lineWidth: 0.5))
                            .fill(Color.init(white: 0.8))
                            .updateMessageGeoSize(geo.size)
                    }
                )
                .frame(maxWidth: 300)
        }
    }
    
    init(messageText: String = "", userName: String = "") {
        self.messageText = messageText
        self.userName = userName
    }
}

struct MessageBlock_Previews: PreviewProvider {
    static let testMessageText: String = "I need an iPod classic with Bluetooth capability."
    static let testUserName: String = "Johnny"
    
    static var previews: some View {
        MessageBlock(messageText: testMessageText, userName: testUserName)
    }
}
