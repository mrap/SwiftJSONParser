//
//  ErrorHandlingTests.swift
//  SwiftJSONParserTests
//
//  Created by mrap on 9/1/14.
//  Copyright (c) 2014 Mike Rapadas. All rights reserved.
//

import UIKit
import XCTest

class ErrorHandlingTests: XCTestCase {
    func testNilData() {
        let parser = JSONParser(nil)
        XCTAssertNotNil(parser.error, "Parser should have an error")
    }
}
