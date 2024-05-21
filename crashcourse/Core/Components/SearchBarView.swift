//
//  SearchBarVıew.swift
//  crashcourse
//
//  Created by Egemen Öngel on 21.05.2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String

    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryText : Color.theme.accent
                )

            TextField("Search coins...",text:$searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x:10)
                    .foregroundColor(Color.theme.accent)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
                , alignment: .trailing
                )
        }    
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10,x: 0,y: 0))
        .padding()

    }
}

@available(iOS 17, *)
#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .previewLayout(.sizeThatFits)
}
