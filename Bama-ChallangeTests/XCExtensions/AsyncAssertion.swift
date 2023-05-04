//
//  AsyncAssertion.swift
//  Bama-ChallangeTests
//
//  Created by Kiarash Vosough on 5/4/23.
//

import XCTest

public func XCTAssertThrowsError<T>(
    _ expression: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: (_ error: Error) -> Void = { _ in }
) async {
    do {
        let _ = try await expression()
        XCTFail("No Error Throwed")
    } catch {
        errorHandler(error)
    }
}
