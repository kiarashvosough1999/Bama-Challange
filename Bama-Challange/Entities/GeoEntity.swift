//
//  GeoEntity.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/2/23.
//

import Foundation

public struct GeoEntity: Hashable, Codable, Sendable {

    public let lat: String
    public let lng: String

    public init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
}
