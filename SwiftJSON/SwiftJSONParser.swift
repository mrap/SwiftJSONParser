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

public class JSONParser {

    class func getFinalValue(json: JSON, withPath path: JSONPath) -> JSON? {
        if let nextKey = path.popNext() {
                }
            }

            if let value: AnyObject = json[nextKey] {
                return getFinalValue(value, withPath: path)
            }
        }

        return json
    }

    public class func get(jsonData: NSData?, path: String?) -> AnyObject? {
        if let json = jsonDictionary(jsonData) as JSONDictionary? {
            return getFinalValue(json, withPath: JSONPath(path) )
        }

        return nil
    }

    public class func getString(jsonData: NSData?, path: String?) -> String? {
        return self.get(jsonData, path: path) as? String
    }

    public class func getInt(jsonData: NSData?, path: String?) -> Int? {
        return self.get(jsonData, path: path) as? Int
    }

    public class func getDouble(jsonData: NSData?, path: String?) -> Double? {
        return self.get(jsonData, path: path) as? Double
    }
}
