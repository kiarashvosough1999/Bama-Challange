//
//  UserListPageView.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import SwiftUI

struct UserListPageView: View {

    @StateObject private var viewModel = UserListPageViewModel()

    var body: some View {
        Form {
            ForEach(viewModel.users) { user in
                UserListItemView(user: user)
                    .padding(.all, 10)
            }
        }
        .task {
            Task {
                await viewModel.load()
            }
        }
    }
}

#if DEBUG
struct UserListPageView_Previews: PreviewProvider {
    static var previews: some View {
        UserListPageView()
    }
}
#endif
