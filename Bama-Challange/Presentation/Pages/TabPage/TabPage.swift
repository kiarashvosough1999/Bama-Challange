//
//  TabPage.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import SwiftUI

fileprivate enum Tabs: Hashable {
    case posts
    case users
}

struct TabPage: View {

    @State private var selectedTab: Tabs = .posts
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PostListPageView()
                .tabItem {
                    Label("Posts", systemImage: "list.bullet.rectangle.portrait")
                }
                .padding(.top, 30)

            UserListPageView()
                .tabItem {
                    Label("Users", systemImage: "person.circle")
                }
        }
    }
}

#if DEBUG
struct TabPage_Previews: PreviewProvider {
    static var previews: some View {
        TabPage()
    }
}
#endif
