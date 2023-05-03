//
//  PersistGeoServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

public protocol PersistGeoServiceProtocol {
    func persist<G>(geos: G) async throws where G: Sequence, G.Element == GeoEntity
}
