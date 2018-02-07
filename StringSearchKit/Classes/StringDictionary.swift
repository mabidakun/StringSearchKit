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

public class StringDictionary: StringDictionaryType {
 
    fileprivate (set) var preservesCase = false
    fileprivate let stringStore = Trie()
    
    lazy var wordMap: [String : String] = {
        return [:]
    }()
    
    // MARK:- Initialisers
    
    public init(withStrings strings: [String], preserveCase: Bool = false) {
        self.preservesCase = preserveCase
        populate(withString: strings)
    }
    
    public convenience init(withTextFileNamed filename: String, preserveCase: Bool = false) {
        self.init(withStrings: StringLoader.load(fromTextFileNamed: filename), preserveCase: preserveCase)
    }

    public convenience init(withTextFilepath filepath: String, preserveCase: Bool = false) {
        self.init(withStrings: StringLoader.load(withFilepath: filepath), preserveCase: preserveCase)
    }
    
    // MARK:- add
    
    public func add(strings: [String]) {
        stringStore.add(strings: strings)
    }
    
    public func add(string: String) {
        stringStore.add(string: string)
    }

    public func contains(string: String) -> Bool {
        return stringStore.contains(string: string)
    }
    
    public func strings(withPrefix prefix: String) -> [String] {
        let results = stringStore.strings(withPrefix: prefix)
        return preservesCase ? originalCaseWords(for: results) : results
    }
}

fileprivate extension StringDictionary {

    func populate(withString strings: [String]) {
        strings.addEntries(to: stringStore)
        
        if preservesCase {
            updateWordMap(withSourceWords: strings)
        }
    }
    
    func updateWordMap(withSourceWords words: [String]) {
        words.forEach{ (originalWord) in
            let matchedWords = stringStore.strings(withPrefix: originalWord)
            let key = originalWord.lowercased()
            if matchedWords.contains(key){
                wordMap[key] = originalWord
            }
        }
    }
    
    func originalCaseWords(for words:[String]) -> [String] {
        return words.map { [weak self] (word) -> String in
            if let originalWord = self?.wordMap[word] {
                return originalWord
            }
            return word
        }
    }
}
