//
//  FetchUserListService.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/2/23.
//

import Foundation

public protocol FetchUserListServiceProtocol {
    func fetchUserList() async throws -> [UserEntity]
}
