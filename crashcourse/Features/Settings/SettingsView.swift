//
//  SettingsView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 24.05.2024.
//

import SwiftUI

struct SettingsView: View {
    let youtubeURL = URL(string: "https://www.youtube.com/@SwiftfulThinking")!
    let coinMarketCapURL = URL(string: "https://coinmarketcap.com/")!
    let personalWebsite = URL(string: "https://egemenongel.com/")!

    var body: some View {
        NavigationStack{
            List{
                apiSection
                developerSection
                swiftfulThinkingSection
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .tint(.blue)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    CloseButton()
            }}
        }
    }
}

extension SettingsView {

    private var swiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            Link(destination: youtubeURL, label: {
                Text("Subscribe on YouTube")
            })
        } header: {
            Text("Swiftful Thinking")
        }
    }

    private var apiSection: some View {
        Section {
            VStack(alignment: .leading){
                Image("coinmarketcap")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinMarketCap!")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            Link(destination: coinMarketCapURL, label: {
                Text("Visit CoinMarketCap")
            })
        } header: {
            Text("CoinMarketCap")
        }

    }

    private var developerSection: some View {
        Section {
            VStack(alignment: .leading){
                Image("me")
                    .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150.0,height: 150.0)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Egemen Öngel. It uses SwitUI and written in Swift.")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            Link(destination: personalWebsite, label: {
                Text("Visit Website")
            })
        } header: {
            Text("developer")
        }

    }
}

#Preview {
    SettingsView()
}


