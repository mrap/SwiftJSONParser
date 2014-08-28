//
//  SwiftJSONTests.swift
//  SwiftJSONTests
//
//  Created by mrap on 8/27/14.
//  Copyright (c) 2014 Mike Rapadas. All rights reserved.
//

import UIKit
import XCTest

class SwiftJSONTests: XCTestCase {
    
    var data :NSData?
    
    override func setUp() {
        super.setUp()
        
        if let path = NSBundle(forClass: SwiftJSONTests.self).pathForResource("BasicTypes", ofType: "json") {
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
}
