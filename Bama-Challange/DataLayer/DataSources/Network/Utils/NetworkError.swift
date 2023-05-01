//
//  NetworkError.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 4/30/23.
//

public enum NetworkError: Error {
    case failedHTTPURLResponseConversion
    case apiURLException
    case requestFailed
    case emptyToken
}
