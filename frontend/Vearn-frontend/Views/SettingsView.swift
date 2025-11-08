//
//  SettingsView.swift
//  Vearn-frontend
//
//  Created by Кайрат Булатов on 08.11.2025.
//

import SwiftUI

struct SettingsView: View {
    let firstSection = ["Notifications and Sounds", "Privacy", "Data and Storage", "Appearance", "Language"]
    let secondSection = ["Ask a question", "Vearn FAQ", "About us"]
    let thirdSection = ["Add account", "Log out", "Delete account"]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .cornerRadius(50)
                    .padding(.top, 10)
                Text("Username")
                    .padding(.top, 5)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Edit")
                        Image(systemName: "square.and.pencil").padding(.bottom, 3)
                    }
                    .padding(.horizontal)
                }.padding(.horizontal)
                List {
                    Section {
                        ForEach(firstSection, id: \.self) { item in
                            Text(item)
                        }
                    }
                    
                    Section {
                        ForEach(secondSection, id: \.self) { item in
                            Text(item)
                        }
                    }
                    Section {
                        ForEach(thirdSection, id: \.self) { item in
                            Text(item)
                                .foregroundColor(item == "Delete account" ? .red : .primary)
                        }
                    }
                }
                .navigationTitle("Settings")
            }
        }
    }
}



#Preview {
    SettingsView()
}
