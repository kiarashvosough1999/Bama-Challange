//
//  CompanyEntityDAO.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/3/23.
//

import CoreData

struct CompanyEntityDAO: DAO {

    typealias LowLevelModel = CDCompanyEntity
    typealias HighLevelModel = CompanyEntity
    typealias Context = NSManagedObjectContext

    func translate(
        _ model: CDCompanyEntity,
        context: NSManagedObjectContext?
    ) throws -> CompanyEntity {
        CompanyEntity(
            name: model.name!,
            catchPhrase: model.catchPhrase!,
            bs: model.bs!
        )
        
    }

    func translate(
        _ model: CompanyEntity,
        context: NSManagedObjectContext?
    ) throws -> CDCompanyEntity {
        guard let context else { throw NSError() }
        let companyObject = CDCompanyEntity(context: context)
        companyObject.bs = model.bs
        companyObject.name = model.name
        companyObject.catchPhrase = model.catchPhrase
        return companyObject
    }
}
