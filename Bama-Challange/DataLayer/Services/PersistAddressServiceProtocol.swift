//
//  PersistAddressServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

public protocol PersistAddressServiceProtocol {
    func persist<A>(addresses: A) async throws where A: Sequence, A.Element == AddressEntity
}
