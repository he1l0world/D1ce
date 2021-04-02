//
//  D1ceApp.swift
//  D1ce
//
//  Created by Dawson Chen on 3/30/21.
//

import SwiftUI

@main
struct D1ceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            HomeView()
        }
    }
}
