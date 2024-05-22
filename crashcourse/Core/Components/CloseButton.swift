//
//  CloseButton.swift
//  crashcourse
//
//  Created by Egemen Öngel on 21.05.2024.
//

import SwiftUI

struct CloseButton: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
               dismiss()
           } label: {
               Image(systemName: "xmark")
                   .font(.headline)
           }
    }
}

#Preview {
    CloseButton()
}
