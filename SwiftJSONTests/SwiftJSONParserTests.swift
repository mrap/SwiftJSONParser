//
//  SwiftJSONParserTests.swift
//  SwiftJSONParserTests
//
//  Created by mrap on 8/27/14.
//  Copyright (c) 2014 Mike Rapadas. All rights reserved.
//

import UIKit
import XCTest

class SwiftJSONParserTests: XCTestCase {
    
    var data :NSData?
    
    override func setUp() {
        super.setUp()
        
        if let path = NSBundle(forClass: SwiftJSONParserTests.self).pathForResource("BasicTypes", ofType: "json") {
            var error: NSError?
            self.data = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: &error)
            XCTAssertNil(error, "Got error reading json file")
            XCTAssertNotNil(data, "JSON data should not be nil")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetStringValue() {
        if let value = JSONParser.getString(data, path: "keyForString") {
            XCTAssertEqual(value, "string", "Should return a String value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testGetNestedStringValue() {
        if let value = JSONParser.getString(data, path: "nested.keyForString") {
            XCTAssertEqual(value, "string", "Should return a String value")
        } else {
            XCTFail("Value should not be nil")
        }
    }

    func testGetIntValue() {
        if let value = JSONParser.getInt(data, path: "keyForInt") {
            XCTAssertEqual(value, 42, "Should return an Int value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testGetNestedIntValue() {
        if let value = JSONParser.getInt(data, path: "nested.keyForInt") {
            XCTAssertEqual(value, 42, "Should return an Int value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
}
