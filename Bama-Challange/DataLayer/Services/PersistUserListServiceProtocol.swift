//
//  PersistUserListServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

public protocol PersistUserListServiceProtocol {
    func persist<U>(users: U) async throws where U: Sequence, U.Element == UserEntity
}
