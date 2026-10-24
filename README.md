# StringSearchKit

A simple library for macOS/iOS/tvOS - enabling fast, in memory, prefix based, string searching, using a Trie.

[![CI](https://github.com/mabidakun/StringSearchKit/actions/workflows/ci.yml/badge.svg)](https://github.com/mabidakun/StringSearchKit/actions/workflows/ci.yml)
[![License](https://img.shields.io/github/license/mabidakun/StringSearchKit.svg?style=flat)](LICENSE)

## Requirements
   - macOS 12+
   - iOS 15+
   - tvOS 15+
   - Swift 5.9+

## Installation

### Swift Package Manager

In Xcode, choose **File > Add Package Dependencies…** and enter `https://github.com/mabidakun/StringSearchKit.git`.

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/mabidakun/StringSearchKit.git", from: "3.0.0")
]
```

Then add `"StringSearchKit"` to your target's dependencies.

### CocoaPods

CocoaPods Trunk goes read-only on 2 December 2026, so 3.0.0 is the final version published there. Swift Package Manager is the supported route for future releases.

```ruby
pod "StringSearchKit"
```

### Why is this framework useful?

Because it makes it really easy to implement **Auto-Complete** functionality in an application - as I did in my macOS™ app - [Sequence Diagram](https://itunes.apple.com/gb/app/sequence-diagram/id1195426709?mt=12) 

### How do I get started?

#### Usage:

   - `StringDictionary(withStrings: [String], preserveCase: Bool = false)`
   - `StringDictionary(withTextFileNamed: <A name of a text file in your Bundle>, bundle: Bundle = .main, preserveCase: Bool = false)`
   - `StringDictionary(withTextFilepath: <The path to a text file>), preserveCase: Bool = false`
   
Using one of the initialisers above, create an instance of `StringDictionary`.

When initialising from a file, it should simply contain one string per-line.

Strings are not limited to being single words - but are in the examples, for simplicity.

Example file contents :-
```
act
apologise
apology
app
apple
```

Once instantiated, use the `StringDictionary` to quickly find strings (case-insensitively) with a given prefix.

```
let stringDictionary = StringDictionary(withStrings: ["act", "app", "apple", "apologise", "apology"])
let searchResults = stringDictionary.strings(withPrefix: "app")

// searchResults will then contain ["app", "apple"]
```

### Search Result Case Preservation

If you set `preserveCase: true` in any of the `init` methods (default is `false` for backwards compatibility), the results will be returned in the same case that the original words were in when added.


For example:

```
let stringDictionary = StringDictionary(withStrings: ["Act", "App", "Apple", "Apologise", "Apology"], preserveCase: true)
let searchResults = stringDictionary.strings(withPrefix: "app")

// searchResults will then contain ["App", "Apple"]
```


## Author

**Mike O. Abidakun** `github@mikeosoft.co.uk`

## License

StringSearchKit is available under the MIT license. See the LICENSE file for more info.

