//
//  crashcourseApp.swift
//  crashcourse
//
//  Created by Egemen Öngel on 26.09.2023.
//

import SwiftUI

@main
struct crashcourseApp: App {
    
    @StateObject private var vm = HomeViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }

    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView().toolbar(.hidden)
            }
            .environmentObject(vm)
        }
    }
}
