//
//  PageLoadState.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/4/23.
//

import SwiftUI

public enum PageLoadState<Model: Equatable>: Equatable {

    case loaded(Model)
    case loading
    case failed(message: String)
}

public struct WithLoadingState<Content, Model>: View where Content: View, Model: Equatable {

    private let state: PageLoadState<Model>
    private let onLoaded: (Model) -> Content
    private var onRetry: (() async -> Void)?

    public init(
        state: PageLoadState<Model>,
        @ViewBuilder onLoaded: @escaping (Model) -> Content
    ) {
        self.state = state
        self.onLoaded = onLoaded
    }

    public var body: some View {
        switch state {
        case .loaded(let model):
            onLoaded(model)
        case .loading:
            BamaProgressView()
        case .failed(let message):
            ErrorView(message: message) {
                await onRetry?()
            }
        }
    }
}

extension WithLoadingState {

    public func onRetry(_ onRetry: @escaping () async -> Void) -> WithLoadingState {
        var mutabelSelf = self
        mutabelSelf.onRetry = onRetry
        return mutabelSelf
    }
}
