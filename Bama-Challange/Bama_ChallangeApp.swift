//
//  Bama_ChallangeApp.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import SwiftUI

@main
struct Bama_ChallangeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TabPage()
            }
        }
    }
}
