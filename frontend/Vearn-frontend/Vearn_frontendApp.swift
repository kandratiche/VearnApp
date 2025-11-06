//
//  Vearn_frontendApp.swift
//  Vearn-frontend
//
//  Created by Кайрат Булатов on 04.11.2025.
//

import SwiftUI

@main
struct Vearn_frontendApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
