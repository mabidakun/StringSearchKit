# StringSearchKit
A simple framework for macOS™ & iOS™ - enabling fast, in memory, prefix based, string searching.

### What is this framework useful?

Because it makes it really easy to implement **Auto-Complete** functionality in an application - as I did in my macOS™ app - [Sequence Diagram](https://itunes.apple.com/gb/app/sequence-diagram/id1195426709?mt=12) 

### How do I get started?

#### Usage:

   - `StringDictionary(withStrings: [String])`
   - `StringDictionary(withTextFileNamed: <A name of a text in your Bundle>)`
   - `StringDictionary(withTextFilepath: <the path to a text file>)`
   
#### Description:

Using one of the initialisers above, create an instance of `StringDictionary`.
The file should simply contain one string per-line.

For example:
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
