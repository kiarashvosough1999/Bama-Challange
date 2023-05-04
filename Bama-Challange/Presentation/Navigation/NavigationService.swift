//
//  NavigationService.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import SwiftUI
import Dependencies

// MARK: - Abstraction

public protocol NavigationServiceProtocol {

    var pathBinding: Binding<NavigationPath> { get }
    
    func push(with value: String)

    func pop(_ count: Int)

    func pop(to value: String)
}

// MARK: - Implementation

public final class NavigationService: ObservableObject {

    internal static let shared = NavigationService()
    
    @Published public var path: NavigationPath

    public var erasedPaths: [String] = []
    
    public init(path: NavigationPath = NavigationPath()) {
        self.path = path
    }
}

extension NavigationService: NavigationServiceProtocol {

    public var pathBinding: Binding<NavigationPath> {
        Binding {
            self.path
        } set: { newValue in
            self.path = newValue
        }
    }

    public func push(with value: String) {
        path.append(value)
        erasedPaths.append(value)
    }

    public func pop(_ count: Int) {
        path.removeLast(count)
        erasedPaths.removeLast(count)
    }

    public func pop(to value: String) {
        guard let index = erasedPaths.firstIndex(where: { $0 == value }) else { return }
        let removingCount = path.count - index
        precondition(removingCount > 0)
        pop(removingCount)
    }
}

// MARK: - Dependency Registeration

extension DependencyValues {

    public var navigationService: NavigationServiceProtocol {
        get { self[NavigationServiceProtocolKey.self] }
        set { self[NavigationServiceProtocolKey.self] = newValue }
    }

    internal enum NavigationServiceProtocolKey: DependencyKey {
        static let liveValue: NavigationServiceProtocol = NavigationService.shared
        static let testValue: NavigationServiceProtocol  = NavigationService.shared
    }
}
