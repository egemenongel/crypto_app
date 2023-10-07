//
//  crashcourseApp.swift
//  crashcourse
//
//  Created by Egemen Öngel on 26.09.2023.
//

import SwiftUI

@main
struct crashcourseApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView().toolbar(.hidden)
            }
        }
    }
}
