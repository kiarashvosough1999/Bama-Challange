//
//  TabPage.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import SwiftUI

struct TabPage: View {

    var body: some View {
        TabView {
            Color
                .red
                .tabItem {
                    Label("Posts", systemImage: "list.bullet.rectangle.portrait")
                }

            Color
                .blue
                .tabItem {
                    Label("Users", systemImage: "person.circle")
                }
        }
    }
}

struct TabPage_Previews: PreviewProvider {
    static var previews: some View {
        TabPage()
    }
}
