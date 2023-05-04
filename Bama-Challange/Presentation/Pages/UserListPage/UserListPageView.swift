//
//  UserListPageView.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import SwiftUI

public struct UserListPageView: View {

    @StateObject private var viewModel = UserListPageViewModel()

    public var body: some View {
        WithLoadingState(state: viewModel.users) { users in
            Form {
                ForEach(users) { user in
                    UserListItemView(user: user)
                        .padding(.all, 10)
                }
            }
        }
        .onRetry {
            await viewModel.load()
        }
        .task {
            await viewModel.load()
        }
        .fixEmptyTabView()
    }
}

#if DEBUG
struct UserListPageView_Previews: PreviewProvider {
    static var previews: some View {
        UserListPageView()
    }
}
#endif
