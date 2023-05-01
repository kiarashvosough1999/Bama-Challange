//
//  GateWays.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Foundation

public enum GateWays: String {
    case base = "https://jsonplaceholder.typicode.com"
}

extension GateWays {
    internal func get() -> URL? {
        return URL(string: rawValue)
    }
}
