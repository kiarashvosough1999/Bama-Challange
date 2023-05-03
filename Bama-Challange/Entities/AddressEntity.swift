//
//  AddressEntity.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/2/23.
//

public struct AddressEntity: Hashable, Codable {

    public let street: String
    public let suite: String
    public let city: String
    public let zipcode: String
    public let geo: GeoEntity

    public init(street: String, suite: String, city: String, zipcode: String, geo: GeoEntity) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
}
