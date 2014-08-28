//
//  JSONPath.swift
//  SwiftJSONParser
//
//  Created by mrap on 8/27/14.
//  Copyright (c) 2014 Mike Rapadas. All rights reserved.
//

import Foundation

public class JSONPath {
    let path: String?
    var pathComponents: Array<String> = []

    init(_ path: String?) {
        if let nsPath = path as NSString? {
            self.path = path
            pathComponents = nsPath.componentsSeparatedByString(".") as Array<String>
        }
    }

    func popNext() -> String? {
        if pathComponents.isEmpty { return nil }
        return pathComponents.removeAtIndex(0)
    }

}
