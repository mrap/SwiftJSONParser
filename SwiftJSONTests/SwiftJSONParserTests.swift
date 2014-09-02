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
    
    var data: NSData?
    var parser = JSONParser()
    
    override func setUp() {
        super.setUp()
        
        if let path = NSBundle(forClass: SwiftJSONParserTests.self).pathForResource("BasicTypes", ofType: "json") {
            var error: NSError?
            self.data = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: &error)
            XCTAssertNil(error, "Got error reading json file")
            XCTAssertNotNil(data, "JSON data should not be nil")
            self.parser = JSONParser(data)
            XCTAssertNil(parser.error, "Parser should not have an error")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetStringValue() {
        if let value = parser.getString("keyForString") {
            XCTAssertEqual(value, "string", "Should return a String value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testGetNestedStringValue() {
        if let value = parser.getString("nested.keyForString") {
            XCTAssertEqual(value, "string", "Should return a String value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testGetIntValue() {
        if let value = parser.getInt("keyForInt") {
            XCTAssertEqual(value, 42, "Should return an Int value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testGetNestedIntValue() {
        if let value = parser.getInt("nested.keyForInt") {
            XCTAssertEqual(value, 42, "Should return an Int value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testGetDoubleValue() {
        if let value = parser.getDouble("keyForDouble") {
            XCTAssertEqual(value, 98.6, "Should return an Double value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testGetNestedDoubleValue() {
        if let value = parser.getDouble("nested.keyForDouble") {
            XCTAssertEqual(value, 98.6, "Should return an Double value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testGetArrayValues() {
        if let stringValue = parser.getString("keyForArray[0]") {
            XCTAssertEqual(stringValue, "string", "Should return a String value")
        } else {
            XCTFail("Value should not be nil")
        }
        
        if let intValue = parser.getInt("keyForArray[1]") {
            XCTAssertEqual(intValue, 42, "Should return a Int value")
        } else {
            XCTFail("Value should not be nil")
        }
        
        if let doubleValue = parser.getDouble("keyForArray[2]") {
            XCTAssertEqual(doubleValue, 98.6, "Should return a Double value")
        } else {
            XCTFail("Value should not be nil")
        }
    }

    func testGetArray() {
        if let array = parser.getArray("keyForArray") {
            let expected = ["string", 42, 98.6]
            XCTAssertEqual(array, expected, "Should return an Array containing correct values")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testNotReturnFalsePositive() {
        if let nonExistent: AnyObject = parser.get("other.nonExistentKey") {
            XCTFail("Value should not be nil")
        }
    }
}
