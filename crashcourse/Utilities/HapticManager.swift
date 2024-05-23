//
//  HapticManager.swift
//  crashcourse
//
//  Created by Egemen Öngel on 23.05.2024.
//

import Foundation
import SwiftUI

class HapticManager {

    static private let generator = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
