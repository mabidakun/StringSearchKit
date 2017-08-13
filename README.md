# StringSearchKit
A simple framework for macOS & iOS - enabling fast, in memory, prefix based, string searching.

### What is this framework useful?

Because, this simple framework makes it really easy to implement Auto-Complete functionality.

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
apologise
apology
app
apple
```

Once instantiated, use the `StringDictionary` to quickly find strings (case-insensitively) with a given prefix.

```
let stringDictionary = StringDictionary(withStrings: ["app", "bob", "bobby", "bobbing"])
let searchResults = stringDictionary.strings(withPrefix: "bobb")

// searchResults will then contain ["bobbing", "bobby"]
```
