# StringSearchKit

A simple framework for macOS™ - enabling fast, in memory, prefix based, string searching.


[![CI Status](http://img.shields.io/travis/mabidakun/StringSearchKit.svg?style=flat)](https://travis-ci.org/mabidakun/StringSearchKit)
[![Version](https://img.shields.io/cocoapods/v/StringSearchKit.svg?style=flat)](http://cocoapods.org/pods/StringSearchKit)
[![License](https://img.shields.io/cocoapods/l/StringSearchKit.svg?style=flat)](http://cocoapods.org/pods/StringSearchKit)
[![Platform](https://img.shields.io/cocoapods/p/StringSearchKit.svg?style=flat)](http://cocoapods.org/pods/StringSearchKit)

## Requirements
   - macOS 10.11+
   - iOS 8+
   - tvOS 9+
   
## Installation

StringSearchKit is available through [CocoaPods](https://github.com/mabidakun/StringSearchKit). To install
it, simply add the following line to your Podfile:

```ruby
pod "StringSearchKit"
```


### Why is this framework useful?

Because it makes it really easy to implement **Auto-Complete** functionality in an application - as I did in my macOS™ app - [Sequence Diagram](https://itunes.apple.com/gb/app/sequence-diagram/id1195426709?mt=12) 

### How do I get started?

#### Usage:

   - `StringDictionary(withStrings: [String])`
   - `StringDictionary(withTextFileNamed: <A name of a text file in your Bundle>)`
   - `StringDictionary(withTextFilepath: <The path to a text file>)`
   
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

## Author

**Mike O. Abidakun** `github@mikeosoft.co.uk`

## License

StringSearchKit is available under the MIT license. See the LICENSE file for more info.

