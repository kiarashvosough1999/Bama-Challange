//
//  Bama_ChallangeApp.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import SwiftUI
import Dependencies

@main
struct Bama_ChallangeApp: App {
    let persistenceController = PersistenceController.shared

    @Dependency(\.navigationService) private var navigationService
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: navigationService.pathBinding) {
                TabPage()
            }.navigationDestination(for: String.self) { pageTitle in
                EmptyView()
            }
        }
    }
}
