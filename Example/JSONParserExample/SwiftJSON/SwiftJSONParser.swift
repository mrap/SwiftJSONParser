//
//  SwiftJSONParser.swift
//  SwiftJSONParser
//
//  Created by mrap on 8/27/14.
//  Copyright (c) 2014 Mike Rapadas. All rights reserved.
//

import Foundation

private typealias _JSON = AnyObject
private typealias _JSONDictionary = Dictionary<String, _JSON>
private typealias _JSONArray = Array<_JSON>

private func jsonDictionary(fromData: NSData?, error: NSErrorPointer) -> _JSONDictionary? {
    if let data = fromData {
        var jsonErrorOptional: NSError?
        if let dict: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonErrorOptional) {
            return dict as? _JSONDictionary
        }
    }

    return nil
}

public class JSONParser {
    private let _json: _JSONDictionary?
    public let error: NSError?

    init() {
    }

    public init(_ data: NSData?) {
        if data != nil {
            self._json = jsonDictionary(data, &self.error)
        } else {
            self.error = NSError(domain: "com.mrap.SwiftJSONParser", code: 100, userInfo: [NSLocalizedDescriptionKey: "Parser did not have any data to parse"])
        }
    }
    
    public func get(path: String?) -> AnyObject? {
        return getFinalValue(_json, withPath: JSONPath(path) )
    }

    public func getString(path: String?) -> String? {
        return self.get(path) as? String
    }

    public func getInt(path: String?) -> Int? {
        return self.get(path) as? Int
    }

    public func getDouble(path: String?) -> Double? {
        return self.get(path) as? Double
    }

    public func getArray(path: String?) -> Array<AnyObject>? {
        return self.get(path) as? Array<AnyObject>
    }

    private func getFinalValue(json: _JSON?, withPath path: JSONPath) -> _JSON? {
        if json == nil { return nil }
        if let nextKey = path.popNext() {

            // Handle _JSONArray type here
            // Get the value from the array and call recursively on the child
            if let (arrayKey, arrayIndex) = JSONPath.getArrayKeyAndIndex(nextKey) {
                if arrayKey != nil && arrayIndex != nil {
                    if let array = json![arrayKey!] as? _JSONArray {
                        return getFinalValue(array[arrayIndex!] as _JSON, withPath: path)
                    }
                }
            }
            
            if let value: AnyObject = json![nextKey] {
                return getFinalValue(value, withPath: path)
            } else {
                return nil
            }
        }

        return json
    }

}
