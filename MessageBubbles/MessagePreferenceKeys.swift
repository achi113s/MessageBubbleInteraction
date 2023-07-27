//
//  MessagePreferenceKeys.swift
//  MessageBubbles
//
//  Created by Giorgio Latour on 7/26/23.
//

import SwiftUI

struct MessageBlockGeometrySizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = CGSize(width: 100, height: 100)
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct ReactionPreferenceData: Equatable {
    let index: Int
    let bounds: CGRect
}

struct ReactionPreferenceKey: PreferenceKey {
    typealias Value = [ReactionPreferenceData]
    
    static var defaultValue: [ReactionPreferenceData] = []
    
    static func reduce(value: inout [ReactionPreferenceData], nextValue: () -> [ReactionPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

extension View {
    func updateMessageGeoSize(_ size: CGSize) -> some View {
        preference(key: MessageBlockGeometrySizePreferenceKey.self, value: size)
    }
    
    func updateReactionPreferenceData(_ reaction: [ReactionPreferenceData]) -> some View {
        preference(key: ReactionPreferenceKey.self, value: reaction)
    }
}

