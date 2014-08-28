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
    
    func testGetDoubleValue() {
        if let value = JSONParser.getDouble(data, path: "keyForDouble") {
            XCTAssertEqual(value, 98.6, "Should return an Double value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testGetNestedDoubleValue() {
        if let value = JSONParser.getDouble(data, path: "nested.keyForDouble") {
            XCTAssertEqual(value, 98.6, "Should return an Double value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
    
    func testGetArrayValues() {
        if let stringValue = JSONParser.getString(data, path: "keyForArray[0]") {
            XCTAssertEqual(stringValue, "string", "Should return a String value")
        } else {
            XCTFail("Value should not be nil")
        }
        
        if let intValue = JSONParser.getInt(data, path: "keyForArray[1]") {
            XCTAssertEqual(intValue, 42, "Should return a Int value")
        } else {
            XCTFail("Value should not be nil")
        }
        
        if let doubleValue = JSONParser.getDouble(data, path: "keyForArray[2]") {
            XCTAssertEqual(doubleValue, 98.6, "Should return a Double value")
        } else {
            XCTFail("Value should not be nil")
        }
    }
}
