//
//  ContentView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 26.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            VStack(spacing: 40){
                Text("Accent").foregroundStyle(Color.theme.accent)
                Text("Secondary Text").foregroundStyle(Color.theme.secondaryText)
                Text("Red").foregroundStyle(Color.theme.red)
                Text("Green").foregroundStyle(Color.theme.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
