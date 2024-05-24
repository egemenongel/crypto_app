//
//  crashcourseApp.swift
//  crashcourse
//
//  Created by Egemen Öngel on 26.09.2023.
//

import SwiftUI

@main
struct crashcourseApp: App {
    @State private var showLaunchView: Bool = true
    @StateObject private var vm = HomeViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }

    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationView{
                    HomeView().toolbar(.hidden)
                }
                .environmentObject(vm)

                if(showLaunchView) {
                    LaunchView(showLaunchView: $showLaunchView)
//                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}
