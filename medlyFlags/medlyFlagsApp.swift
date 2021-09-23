//
//  medlyFlagsApp.swift
//  medlyFlags
//
//  Created by elliott on 9/16/21.
//

import SwiftUI

@main
struct medlyFlagsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            FlagListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
