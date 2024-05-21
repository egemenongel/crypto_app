//
//  UIApplication.swift
//  crashcourse
//
//  Created by Egemen Öngel on 21.05.2024.
//

import Foundation
import SwiftUI

extension UIApplication {

    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
