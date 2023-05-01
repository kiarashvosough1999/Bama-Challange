//
//  NetworkServices.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

import Foundation

public final class NetworkServices {
    internal static let shared = NetworkServices()

    internal let session: URLSession
    
    private init() {
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration)
    }
}
