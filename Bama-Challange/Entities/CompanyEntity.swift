//
//  CompanyEntity.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/2/23.
//

public struct CompanyEntity: Hashable {
    public let name: String
    public let catchPhrase: String
    public let bs: String

    public init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
