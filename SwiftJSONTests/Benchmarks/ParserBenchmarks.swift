//
//  ParserBenchmarks.swift
//  SwiftJSONParser
//
//  Created by mrap on 1/11/15.
//  Copyright (c) 2015 Mike Rapadas. All rights reserved.
//

import UIKit
import XCTest

class ParserBenchmarks: XCTestCase {
    
    var data: NSData?
    var tweetData: NSData?
    let iterations = 10000;

    override func setUp() {
        super.setUp()
        
        if let path = NSBundle(forClass: SwiftJSONParserTests.self).pathForResource("BasicTypes", ofType: "json") {
            var error: NSError?
            self.data = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: &error)
        }
        
        if let path = NSBundle(forClass: SwiftJSONParserTests.self).pathForResource("TweetsSearch", ofType: "json") {
            var error: NSError?
            self.tweetData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: &error)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func benchmark(fn: ()->Void) {
        self.measureBlock() {
            for i in 0...self.iterations {
                fn();
            }
        }
    }

    func testParserInit() {
        benchmark() {
            let parser = JSONParser(self.tweetData)
        }
    }
    
    func testSwiftyInit() {
        benchmark() {
            let swifty = JSON(data: self.tweetData!)
        }
    }
    
    func testParserString() {
        let parser = JSONParser(self.data)
        benchmark() {
            if let val = parser.getString("keyForString") {
                XCTAssertEqual(val, "string", "Not expected value")
            } else {
                XCTFail("Should have string value");
            }
        }
    }

    func testSwiftyString() {
        let swifty = JSON(data: self.data!)
        benchmark() {
            if let val = swifty["keyForString"].string {
                XCTAssertEqual(val, "string", "Not expected value")
            } else {
                XCTFail("Should have string value");
            }
        }
    }
    
    func testParserNestedString() {
        let parser = JSONParser(self.data)
        benchmark() {
            if let val = parser.getString("nested.keyForString") {
                XCTAssertEqual(val, "string", "Not expected value")
            } else {
                XCTFail("Should have string value");
            }
        }
    }
    
    func testSwiftyNestedString() {
        let swifty = JSON(data: self.data!)
        benchmark() {
            if let val = swifty["nested"]["keyForString"].string {
                XCTAssertEqual(val, "string", "Not expected value")
            } else {
                XCTFail("Should have string value");
            }
        }
    }
    
    func testParserNestedArrayString() {
        let parser = JSONParser(self.data)
        benchmark() {
            if let val = parser.getString("nested.keyForArray[0]") {
                XCTAssertEqual(val, "string", "Not expected value")
            } else {
                XCTFail("Should have string value");
            }
        }
    }

    func testSwiftyNestedArrayString() {
        let swifty = JSON(data: self.data!)
        benchmark() {
            if let val = swifty["nested"]["keyForArray"][0].string {
                XCTAssertEqual(val, "string", "Not expected value")
            } else {
                XCTFail("Should have string value");
            }
        }
    }
    
    func testParserNestedNestedString() {
        let parser = JSONParser(self.data)
        benchmark() {
            if let val = parser.getString("nested.nested.keyForString") {
                XCTAssertEqual(val, "string", "Not expected value")
            } else {
                XCTFail("Should have string value");
            }
        }
    }
    
    func testSwiftyNestedNestedString() {
        let swifty = JSON(data: self.data!)
        benchmark() {
            if let val = swifty["nested"]["nested"]["keyForString"].string {
                XCTAssertEqual(val, "string", "Not expected value")
            } else {
                XCTFail("Should have string value");
            }
        }
    }
    
}
