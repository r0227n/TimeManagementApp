//
//  TimeManagementAppApp.swift
//  TimeManagementApp
//
//  Created by RyoNishimura on 2020/09/19.
//

import SwiftUI

@main
struct TimeManagementAppApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            TimeStartView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(RecordViewModel())
        }
    }
}
