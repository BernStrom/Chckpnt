//
//  ChckpntApp.swift
//  Chckpnt
//
//  Created by Bern N on 12/25/23.
//

import SwiftUI
import SwiftData

@main
struct ChckpntApp: App {
    var body: some Scene {
        WindowGroup {
            ProjectListView()
                .modelContainer(for: [Project.self, ProjectUpdate.self])
        }
    }
}
