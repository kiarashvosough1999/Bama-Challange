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
    
    var body: some Scene {
        WindowGroup {
            Root(navigationService: NavigationService.shared) {
                TabPage()
                    .navigationDestination(for: String.self) { pageTitle in
                        switch pageTitle {
                        case "PostDetailPage":
                            PostDetailPageView()
                        default:
                            EmptyView()
                        }
                    }
            }
        }
    }
}

struct Root<Content>: View where Content: View {

    @ObservedObject private var navigationService: NavigationService
    private let content: () -> Content

    init(navigationService: NavigationService, _ content: @escaping () -> Content) {
        self.navigationService = navigationService
        self.content = content
    }
    
    var body: some View {
        NavigationStack(path: $navigationService.path) {
            content()
        }
    }
}
