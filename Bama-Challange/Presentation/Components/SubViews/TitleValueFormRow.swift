//
//  TitleValueFormRow.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import SwiftUI

public struct TitleValueFormRow: View {

    private let title: String
    private let value: String

    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }

    public var body: some View {
        HStack {
            Text(title)
                .bold()
            Spacer()
            Text(value)
        }
    }
}
