# Parse JSON like a badass

### Full disclaimer regarding performance

For production apps (or if you care about efficiency at all),
I highly recommend using [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
over this library. After benchmarking, I found that SwiftJSONParser could be
up to 7x slower than SwiftyJSON.

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

### This is readable

```swift
let jsonData = NSData(contentsOfURL: NSURL(string: url))
let parser = JSONParser(jsonData)

if let handle = parser.getString("other.nicknames[0]") {
    println("Some folks call me \(handle)")
}
```


## Usage

Sample JSON payload we want to parse like a badass

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

If you're not sure about incoming json data, be a badass and check it first

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

## Installation
The most badass way to use SwiftJSONParser is to import it as a framework.

1.  Clone a local copy of SwiftJSONParser in any directory you'd like.
``
git clone git@github.com:mrap/SwiftJSONParser.git
``
2. Drag `SwiftJSONParser.xcodeproj` into your project's project navigator

3. Add SwiftJSONParser as a Target Dependency.
- Go to your App Target > Build Phases
- In Target Dependencies, press `+`, select `SwiftJSONParser`
