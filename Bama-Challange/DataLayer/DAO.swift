//
//  DAO.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Foundation

public protocol DAO {

    associatedtype LowLevelModel
    associatedtype HighLevelModel
    associatedtype Context = Void

    func translate(_ model: LowLevelModel, context: Context?) throws -> HighLevelModel
    func translate(_ model: HighLevelModel, context: Context?) throws -> LowLevelModel
}
