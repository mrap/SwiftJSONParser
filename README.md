# Parse JSON like a badass

### This sucks

```swift
let jsonData = NSData(contentsOfURL: NSURL(string: url))
var jsonErrorOptional: NSError?
let jsonOptional: AnyObject! = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions(0), error: &jsonErrorOptional)

if let json = jsonOptional as? Dictionary<String, AnyObject> {
    if let other = json["other"] as? Dictionary<String, AnyObject> {
        if let nicknames = other["nicknames"] as? Array<String> {
            if let handle = nicknames[0] as AnyObject? as? String {
                println("Some folks call me \(handle)")
            }
        }
    }
}
```

### This is badass (and readable)

```swift
let jsonData = NSData(contentsOfURL: NSURL(string: url))
let parser = JSONParser(jsonData)

if let handle = parser.getString("other.nicknames[0]") {
    println("Some folks call me \(handle)")
}
```


## Usage

Sample JSON payload we want to parse

    {
        "name": "Mike",
        "favorite_number": 19,
        "gpa": 2.6,
        "favorite_things": ["Github", 42, 98.6],
        "other": {
            "city": "San Francisco",
            "commit_count": 9000,
            "nicknames": ["mrap", "Mikee"]
        }
    }

Get values of a specific type. Returns optionals

```swift
if let name = parser.getString("name") {
    println("My name is \(name)")
}

if let number = parser.getInt("favorite_number") {
    println("\(number) is my favorite number!")
}

if let gpa = parser.getDouble("gpa") {
    println("My stellar highschool gpa was \(gpa)")
}
```

Or get `AnyObject` if you're not sure

```swift
if let city = parser.get("other.city") {
    // city will be type AnyObject
}
```

Get an Array of values

```swift
if let favorites = parser.getArray("favorite_things") {
    // favorites => ["Github", 42, 98.6]
}
```

## Error Handling

If you're not sure about incoming json data, check it first

```swift
let badJsonData = NSData(contentsOfURL: NSURL(string: url))
let parser = JSONParser(badJsonData)

// Check for an error
if parser.error != nil {
   // Do stuff with json
} else {
   // Handle the error
   println(parser.error)
}
```

And now you're a badass. Enjoy.
