//
//  JSONParserExampleTests.swift
//  JSONParserExampleTests
//
//  Created by mrap on 1/11/15.
//  Copyright (c) 2015 mrap. All rights reserved.
//

import UIKit
import XCTest
import SwiftJSONParser

class JSONParserExampleTests: XCTestCase {
    
    var data: NSData?
    var parser = JSONParser(nil)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
        if let path = NSBundle(forClass: JSONParserExampleTests.self).pathForResource("BasicTypes", ofType: "json") {
            var error: NSError?
            self.data = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: &error)
            self.parser = JSONParser(data)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseWithParser() {
        self.measureBlock() {
            for i in 0...10000 {
                if let val = self.parser.getString("keyForString") {
                } else {
                    XCTFail("Should have string value")
                }
            }
        }
    }
    
    func testParse() {
        self.measureBlock() {
            for i in 0...10000 {
                var parseError: NSError?
                let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(self.data!,
                    options: NSJSONReadingOptions.AllowFragments,
                    error:&parseError)
                
                if let top = parsedObject as? NSDictionary {
                    if let val = top["keyForString"] as? String {
                    } else {
                        XCTFail("Should have string value")
                    }
                }
            }
        }
    }
    
    func testParseArray() {
        self.measureBlock() {
            for i in 0...10000 {
                var parseError: NSError?
                let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(self.data!,
                    options: NSJSONReadingOptions.AllowFragments,
                    error:&parseError)
                
                if let top = parsedObject as? NSDictionary {
                    if let arr = top["keyForArray"] as? [AnyObject] {
                        XCTAssertEqual(arr[0] as String, "string", "Should have string value")
                    } else {
                        XCTFail("Should have string value")
                    }
                }
            }
        }
    }
}
