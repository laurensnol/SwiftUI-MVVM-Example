//
//  SwiftUI_MVVM_ExampleApp.swift
//  SwiftUI MVVM Example
//
//  Created by Laurens Nolting on 16.10.20.
//

import SwiftUI

@main
struct SwiftUI_MVVM_ExampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
