//
//  UserModel.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/2/23.
//

public struct UserEntity: Hashable {

    public let id: Int
    public let name: String
    public let username: String
    public let email: String
    public let address: AddressEntity
    public let phone: String
    public let website: String
    public let company: CompanyEntity

    public init(
        id: Int,
        name: String,
        username: String,
        email: String,
        address: AddressEntity,
        phone: String,
        website: String,
        company: CompanyEntity
    ) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
}
