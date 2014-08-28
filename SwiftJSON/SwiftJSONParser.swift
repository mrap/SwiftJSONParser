//
//  SwiftJSONParser.swift
//  SwiftJSONParser
//
//  Created by mrap on 8/27/14.
//  Copyright (c) 2014 Mike Rapadas. All rights reserved.
//

import Foundation

typealias JSON = AnyObject
typealias JSONDictionary = Dictionary<String, JSON>
typealias JSONArray = Array<JSON>

func jsonDictionary(fromData: NSData?) -> JSONDictionary? {
    if let data = fromData {
        var jsonErrorOptional: NSError?
        if let dict: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonErrorOptional) {
            return dict as? JSONDictionary
        }
    }

    return nil
}

func getFinalValue(json: JSON, withPath path: JSONPath) -> JSON? {
    if let nextKey = path.popNext() {
        if let value: AnyObject = json[nextKey] {
            switch value {
            case is String:
                return value as JSON
            case let nestedJson as JSONDictionary:
                return getFinalValue(nestedJson, withPath: path)
            default:
                return json
            }
        }
    }

    return json
}

public class JSONParser {
    public class func get(jsonData: NSData?, path: String?) -> AnyObject? {
        if let json = jsonDictionary(jsonData) as JSONDictionary? {
            return getFinalValue(json, withPath: JSONPath(path) )
        }

        return nil
    }
}
