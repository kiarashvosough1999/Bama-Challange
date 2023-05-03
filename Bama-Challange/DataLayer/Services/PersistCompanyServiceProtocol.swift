//
//  PersistCompanyServiceProtocol.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

public protocol PersistCompanyServiceProtocol {
    func persist<C>(companies: C) async throws where C: Sequence, C.Element == CompanyEntity
}
