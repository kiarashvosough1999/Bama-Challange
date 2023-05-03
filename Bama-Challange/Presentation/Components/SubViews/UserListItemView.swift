//
//  UserListItemView.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import SwiftUI
import MapKit

struct UserListItemView: View {

    private let user: UserListPageViewModel.UserModel
    
    @State private var region: MKCoordinateRegion?
    
    init(user: UserListPageViewModel.UserModel) {
        self.user = user
        if let geo = user.address.geo {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: geo.lat,
                    longitude: geo.lng
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.5,
                    longitudeDelta: 0.5
                )
            )
            _region = State(initialValue: region)
        }
    }
    
    var body: some View {
        Section(user.name) {
            TitleValueFormRow(title: "Phone", value: user.phone)
            TitleValueFormRow(title: "Email", value: user.email)
            TitleValueFormRow(title: "Username", value: user.username)
            TitleValueFormRow(title: "Website", value: user.website)
            DisclosureGroup("Address") {
                TitleValueFormRow(title: "City", value: user.address.city)
                TitleValueFormRow(title: "Street", value: user.address.street)
                TitleValueFormRow(title: "Suite", value: user.address.suite)
                TitleValueFormRow(title: "ZipCode", value: user.address.zipcode)
                if region != nil {
                    let binding = Binding(get: {
                        region!
                    }, set: { newValue in
                        region = newValue
                    })
                    Map(coordinateRegion: binding)
                        .frame(width: 300, height: 200)
                }
            }
        }
    }
}

#if DEBUG
struct UserListItemView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            UserListItemView(
                user: UserListPageViewModel.UserModel(
                    id: 1,
                    name: "test",
                    username: "test",
                    email: "test",
                    address: UserListPageViewModel.AddressModel(
                        street: "test",
                        suite: "test",
                        city: "test",
                        zipcode: "test",
                        geo: UserListPageViewModel.GeoModel(
                            lat: 38.8951,
                            lng: -77.0364
                        )
                    ),
                    phone: "test",
                    website: "test",
                    company: UserListPageViewModel.CompanyModel(
                        name: "test",
                        catchPhrase: "test",
                        bs: "test"
                    )
                )
            )

        }
    }
}
#endif
