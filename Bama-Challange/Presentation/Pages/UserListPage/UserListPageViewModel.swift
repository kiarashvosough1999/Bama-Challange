//
//  UserListPageViewModel.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import Foundation
import Dependencies

internal final class UserListPageViewModel: ObservableObject {

    @Published internal var users: PageLoadState<[UserModel]> = .loading
    @Dependency(\.fetchUsersRepository) private var fetchUsersRepository

    @MainActor
    internal func load() async {
        do {
            let loadedUsers = try await fetchUsersRepository.fetchUsers().map { user in
                UserModel(
                    id: user.id,
                    name: user.name,
                    username: user.username,
                    email: user.email,
                    address: AddressModel(
                        street: user.address.street,
                        suite: user.address.suite,
                        city: user.address.city,
                        zipcode: user.address.zipcode,
                        geo: .from(user.address.geo)
                    ),
                    phone: user.phone,
                    website: user.website,
                    company: CompanyModel(
                        name: user.company.name,
                        catchPhrase: user.company.catchPhrase,
                        bs: user.company.bs
                    )
                )
            }
            self.users = .loaded(loadedUsers)
        } catch {
            self.users = .failed(message: "Failed To Load")
        }
    }
}

extension UserListPageViewModel {
    
    internal struct UserModel: Identifiable, Hashable {
        internal let id: Int32
        internal let name: String
        internal let username: String
        internal let email: String
        internal let address: AddressModel
        internal let phone: String
        internal let website: String
        internal let company: CompanyModel
    }

    internal struct AddressModel: Hashable {
        internal let street: String
        internal let suite: String
        internal let city: String
        internal let zipcode: String
        internal let geo: GeoModel?
    }

    internal struct GeoModel: Hashable {
        internal let lat: Double
        internal let lng: Double

        static func from(_ entity: GeoEntity) -> GeoModel? {
            guard let lat = Double(entity.lat), let lng = Double(entity.lng) else { return nil }
            return GeoModel(lat: lat, lng: lng)
        }
    }

    internal struct CompanyModel: Hashable {
        internal let name: String
        internal let catchPhrase: String
        internal let bs: String
    }
}
