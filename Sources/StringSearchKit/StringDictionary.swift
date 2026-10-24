//
//  Created by Mike O. Abidakun 2017.
//  Copyright (c) 2017-Present Mike O. Abidakun. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// A dictionary-like collection that supports prefix-based string searching.
///
/// `StringDictionary` wraps a trie data structure to provide efficient
/// prefix matching and membership testing for a collection of strings.
///
/// Strings can be loaded from an array, a named text file resource in a
/// bundle (the main bundle by default), or a file path on disk. Each string
/// in the file should appear on its own line.
///
/// ## Case Sensitivity
///
/// By default, lookups are case-insensitive. When `preserveCase` is `true`,
/// results returned by ``strings(withPrefix:)`` retain their original casing.
///
/// ## Example
///
/// ```swift
/// let dict = StringDictionary(withStrings: ["Alice", "Bob", "Alice2"], preserveCase: true)
/// dict.strings(withPrefix: "ali") // ["Alice", "Alice2"]
/// ```
public class StringDictionary: StringDictionaryType {

    private(set) var preservesCase = false
    fileprivate let stringStore = Trie()

    lazy var wordMap: [String: String] = {
        return [:]
    }()

    // MARK: - Initialisers

    /// Creates a string dictionary populated with the given strings.
    ///
    /// - Parameters:
    ///   - strings: The strings to insert into the dictionary.
    ///   - preserveCase: When `true`, results from ``strings(withPrefix:)``
    ///     retain their original casing. Defaults to `false`.
    public init(withStrings strings: [String], preserveCase: Bool = false) {
        self.preservesCase = preserveCase
        populate(with: strings)
    }

    /// Creates a string dictionary by loading strings from a text file resource
    /// in a bundle.
    ///
    /// The file is expected to contain one string per line. If the file cannot
    /// be found, the dictionary is created empty.
    ///
    /// - Parameters:
    ///   - filename: The name of the text file resource (without the `.txt`
    ///     extension) to load from `bundle`.
    ///   - bundle: The bundle that contains the resource. Defaults to the
    ///     main bundle. Pass `Bundle.module` for a resource in a Swift
    ///     package target.
    ///   - preserveCase: When `true`, results from ``strings(withPrefix:)``
    ///     retain their original casing. Defaults to `false`.
    public convenience init(withTextFileNamed filename: String, bundle: Bundle = .main, preserveCase: Bool = false) {
        self.init(withStrings: StringLoader.load(fromTextFileNamed: filename, in: bundle), preserveCase: preserveCase)
    }

    /// Creates a string dictionary by loading strings from a text file at the
    /// given file path.
    ///
    /// The file is expected to contain one string per line. If the file cannot
    /// be read, the dictionary is created empty.
    ///
    /// - Parameters:
    ///   - filepath: The absolute path to the text file to load.
    ///   - preserveCase: When `true`, results from ``strings(withPrefix:)``
    ///     retain their original casing. Defaults to `false`.
    public convenience init(withTextFilepath filepath: String, preserveCase: Bool = false) {
        self.init(withStrings: StringLoader.load(withFilepath: filepath), preserveCase: preserveCase)
    }

    // MARK: - add

    /// Adds multiple strings to the dictionary.
    ///
    /// - Parameter strings: The strings to insert.
    public func add(strings: [String]) {
        stringStore.add(strings: strings)
    }

    /// Adds a single string to the dictionary.
    ///
    /// - Parameter string: The string to insert.
    public func add(string: String) {
        stringStore.add(string: string)
    }

    /// Returns a Boolean value indicating whether the dictionary contains the
    /// given string.
    ///
    /// The lookup is case-insensitive.
    ///
    /// - Parameter string: The string to search for.
    /// - Returns: `true` if the dictionary contains `string`; otherwise,
    ///   `false`.
    public func contains(string: String) -> Bool {
        return stringStore.contains(string: string)
    }

    /// Returns all strings in the dictionary that begin with the given prefix.
    ///
    /// When the dictionary was created with `preserveCase` set to `true`, the
    /// returned strings retain their original casing; otherwise they are
    /// lowercased.
    ///
    /// - Parameter prefix: The prefix to match against. Pass an empty string
    ///   (the default) to return all strings in the dictionary.
    /// - Returns: An array of matching strings, which may be empty.
    public func strings(withPrefix prefix: String = "") -> [String] {
        let results = stringStore.strings(withPrefix: prefix)
        return preservesCase ? originalCaseWords(for: results) : results
    }
}

// MARK: -
private extension StringDictionary {

    func populate(with strings: [String]) {
        strings.addEntries(to: stringStore)

        if preservesCase {
            wordMap = createWordMap(using: strings,
                                    finder: stringStore.strings(withPrefix:))
        }
    }

    func createWordMap(using words: [String], finder find: (String) -> [String]) -> [String: String] {

        return words.reduce(into: [String: String]()) { (wordMap, originalWord) in
            let matchedWords = find(originalWord)
            let key = originalWord.lowercased()
            if matchedWords.contains(key) {
                wordMap[key] = originalWord
            }
        }
    }

    func originalCaseWords(for words: [String]) -> [String] {
        return words.map { [weak self] (word) -> String in
            if let originalWord = self?.wordMap[word] {
                return originalWord
            }
            return word
        }
    }
}
