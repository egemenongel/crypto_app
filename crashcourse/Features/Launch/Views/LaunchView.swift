//
//  LaunchView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 24.05.2024.
//

import SwiftUI



struct LaunchView: View {
    @Binding var showLaunchView: Bool

    var body: some View {
        ZStack{
            Color.launchTheme.background.ignoresSafeArea()
            VStack{
                Image("logo-transparent")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showLaunchView = false
                }
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
