//
//  MessageReactionGestureState.swift
//  MessageBubbles
//
//  Created by Giorgio Latour on 7/26/23.
//

import Foundation

enum MessageReactionGestureState {
    case inactive
    case pressing
    case finishedLongPress
    case dragging(translation: CGSize)
    
    var isActive: Bool {
        switch self {
        case .inactive:
            return false
        case .pressing, .finishedLongPress, .dragging:
            return true
        }
    }
    
    var isLongPressing: Bool {
        switch self {
        case .inactive, .finishedLongPress, .dragging:
            return false
        case .pressing:
            return true
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive, .pressing, .finishedLongPress:
            return false
        case .dragging:
            return true
        }
    }
}
