//
//  AccessibilityIdentfiable.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/5/23.
//

import SwiftUI

public protocol AccessibilityIdentfiable: RawRepresentable where RawValue == String {}

extension AccessibilityIdentfiable {
    public var accessibilityIdentifier: String {
        self.rawValue
    }
}

extension View {

    public func accessibilityIdentifier<A>(
        _ identifier: A
    ) -> some View where A: AccessibilityIdentfiable {
        self.accessibilityIdentifier(identifier.accessibilityIdentifier)
    }
}
