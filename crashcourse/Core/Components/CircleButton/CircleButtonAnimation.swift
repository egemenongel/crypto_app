//
//  CircleButtonAnimation.swift
//  crashcourse
//
//  Created by Egemen Öngel on 7.10.2023.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none)
            .onAppear{
                animate.toggle()
            }
    }
}

@available(iOS 17, *)
#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonAnimation(animate: .constant(false))
        .frame(width: 100,height: 100)
        .foregroundStyle(.red)
}
