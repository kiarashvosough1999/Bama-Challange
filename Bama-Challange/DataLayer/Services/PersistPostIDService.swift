//
//  PostIDService.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import Foundation

public protocol PersistPostIDServiceProtocol {
    func persistPost(id: Int32)
    func retreivePostId() -> Int32?
}
