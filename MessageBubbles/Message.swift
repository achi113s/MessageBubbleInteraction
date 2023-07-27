//
//  Message.swift
//  MessageBubbles
//
//  Created by Giorgio Latour on 7/26/23.
//

import CoreHaptics
import SwiftUI

struct Message: View {
    let message: String
    let user: String
    
    let minimumLongPressDuration = 0.5
    let reactionAnimationDuration = 0.2
    
    let descriptions: [MessageReactionType] = [.reply, .love, .dislike, .shareTo]
    let offsetsY: [CGFloat] = [0, -40, -40, 0]
    let offsetsX: [CGFloat] = [0, -5, 5, 0]
    let angles: [Double] = [-25, -10, 10, 20]
    let reactionSize: CGFloat = 45.0
    
    @GestureState private var messageReactionGestureState = MessageReactionGestureState.inactive
    @State private var showReactions: Bool = false
    
    @State private var hapticEngine: CHHapticEngine?
    @State private var reactionIconSpacing: CGFloat = 10
    
    @State private var selectedReactionIndex: Int = -1
    @State private var reactionsData: [ReactionPreferenceData] = [ReactionPreferenceData]()
    
    @State private var lastCalledReaction: String = "None"
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.gray)
                .opacity(showReactions ? 0.3 : 0.001)
                .ignoresSafeArea()
                .onTapGesture {
                    showReactions = false
                }
                .animation(.linear(duration: reactionAnimationDuration), value: showReactions)
            
            VStack {
                HStack(spacing: reactionIconSpacing) {
                    ForEach((0...3), id: \.self) { index in
                        VStack(spacing: 5) {
                            Text(descriptions[index].description)
                                .font(.system(size: 10))
                                .opacity(selectedReactionIndex == index ? 1.0 : 0.0)
                            
                            MessageReaction(symbol: descriptions[index].symbol,
                                            color: descriptions[index].color,
                                            size: reactionSize,
                                            description: descriptions[index]
                            )
                            .scaleEffect(selectedReactionIndex == index ? 1.2 : 1.0)
                        }
                        .offset(y: selectedReactionIndex == index ? -10 : 0)
                        .animation(.linear(duration: reactionAnimationDuration), value: selectedReactionIndex)
                        .background(
                            GeometryReader { geo in
                                Rectangle()
                                    .fill(Color.clear)
                                    .updateReactionPreferenceData(
                                        [ReactionPreferenceData(index: index,
                                                                bounds: geo.frame(in: .named("message"))
                                                               )
                                        ]
                                    )
                            }
                        )
                        .rotationEffect(Angle(degrees: angles[index]), anchor: .bottom)
                        .offset(x: offsetsX[index], y: offsetsY[index])
                    }
                }
                .scaleEffect(showReactions ? 1 : 0, anchor: .bottom)
                .opacity(showReactions ? 1 : 0)
                .animation(.interpolatingSpring(stiffness: 170, damping: 15),
                           value: showReactions
                )
                
                MessageBlock(messageText: message, userName: user)
                    .scaleEffect(messageReactionGestureState.isLongPressing ? 0.95 : 1.0)
                    .animation(.easeIn(duration: reactionAnimationDuration), value: messageReactionGestureState.isLongPressing)
                
                Text("Last Reaction: \(lastCalledReaction)")
            }
            .onPreferenceChange(MessageBlockGeometrySizePreferenceKey.self) { value in
                reactionIconSpacing = value.width / 25
            }
            .onPreferenceChange(ReactionPreferenceKey.self) { value in
                reactionsData = value
            }
            .gesture(
                LongPressGesture(minimumDuration: minimumLongPressDuration)
                    .updating($messageReactionGestureState) { value, state, transaction in
                        state = .pressing
                        // value stores the current value of the gesture
                        // state allows us to modify the value
                        // transaction stores the context of the current processing state
                    }
                    .onEnded { value in
                        showReactions.toggle()
                        playSuccessHaptic()
                    }
                    .sequenced(before: DragGesture())
                    .updating($messageReactionGestureState) { value, state, transaction in
                        switch value {
                        case .first(true):
                            state = .pressing
                        case .second(true, let dragValue):
                            state = .dragging(translation: dragValue?.translation ?? .zero)
                            if let location = dragValue?.location {
                                if let data = reactionsData.first(where: { $0.bounds.contains(location) }) {
                                    Task {
                                        await MainActor.run {
                                            selectedReactionIndex = data.index
                                        }
                                    }
                                }
                            }
                        default:
                            state = .inactive
                            showReactions = false
                            selectedReactionIndex = -1
                            print("set selected to -1")
                        }
                    }
                    .onEnded { _ in
                        if selectedReactionIndex != -1 {
                            lastCalledReaction = descriptions[selectedReactionIndex].description
                        }
                        selectedReactionIndex = -1
                        print("set selected to -1")
                        showReactions = false
                    }
            )
            .coordinateSpace(name: "message")
            .onAppear(perform: prepareHaptics)
        }
    }
}

struct Message_Previews: PreviewProvider {
    static let message: String = "I need an iPod classic with Bluetooth capability."
    static let user: String = "Johnny"
    
    static var previews: some View {
        Message(message: message, user: user)
    }
}

extension Message {
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("There was an error creating the haptic engine: \(error.localizedDescription)")
        }
    }
    
    private func playSuccessHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}
