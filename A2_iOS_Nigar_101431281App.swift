//
//  A2_iOS_Nigar_101431281App.swift
//  A2_iOS_Nigar_101431281
//
//  Created by Nigar Ahmadova on 2025-03-26.
//

import SwiftUI

@main
struct A2_iOS_Nigar_101431281App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
