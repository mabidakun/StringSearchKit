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

import XCTest
@testable import StringSearchKit

class TrieTests: XCTestCase {
    
    fileprivate var trie: Trie!

    override func setUp() {
        trie = Trie()
    }

    // MARK:- addString
    
    func testAddString_EmptyString_ContainsWordIsFalse() {
        trie.add(string: "")
        XCTAssertFalse(trie.contains(string: ""))
    }

    func testAddString_Word_ContainsWordIsTrue() {
        let word = "word"
        trie.add(string: word)
        XCTAssertTrue(trie.contains(string: word))
    }
    
    // MARK:- removeString

    func testRemoveString_Word_ContainsWordIsFalse() {
        let word = "word"
        trie.add(string: word)
        trie.remove(string: word)
        XCTAssertFalse(trie.contains(string: word))
    }
    
    func testRemoveString_MixedCase_ContainsWordIsFalse() {
        trie.add(string: "WoRd")
        trie.remove(string: "wOrD")
        XCTAssertFalse(trie.contains(string: "word"))
    }

    func testRemoveString_ExtendedWord_RootWordIsPreserved() {
        
        trie.add(string: "fixed")
        trie.add(string: "fix")
        trie.remove(string: "fixed")
        
        XCTAssertTrue(trie.contains(string: "fix"))
        XCTAssertFalse(trie.contains(string: "fixed"))
    }
    
    // MARK:- containsString

    func testContainsString_AfterInit_ReturnsFalse() {
        XCTAssertFalse(trie.contains(string: "word"))
    }

    func testContainsString_NonExistentWord_ReturnsFalse() {
        let word = "word"
        trie.add(string: word)
        
        XCTAssertFalse(trie.contains(string: "biscuit"))
    }
    
    func testContainsString_AddMixedCaseWord_ReturnsTrue() {
        trie.add(string: "WoRd")
        XCTAssertTrue(trie.contains(string: "word"))
    }

    func testContainsString_AddMixedCaseWordFindDifferentCase_ReturnsTrue() {
        trie.add(string: "WoRd")
        XCTAssertTrue(trie.contains(string: "WORD"))
    }
    
    func testContainsString_AddWithWrappingWhitespace_ReturnsTrue() {
        trie.add(string: " word ")
        XCTAssertTrue(trie.contains(string: "word"))
    }

    func testContainsString_SearchWithWrappingWhitespace_ReturnsTrue() {
        trie.add(string: "word")
        XCTAssertTrue(trie.contains(string: " word "))
    }
    
    func testContainsString_AddStringContainingWhitespace_ReturnsTrue() {
        let string = "a sentence is this"
        trie.add(string: string)
        XCTAssertTrue(trie.contains(string: string))
    }
    
    // MARK:- extended word forms (for example, past tense)
    
    func testAddExtendedForms_ContainsWordsIsTrue() {
        
        trie.add(string: "Fix")
        trie.add(string: "Fixed")
        trie.add(string: "Fixing")
        
        XCTAssertTrue(trie.contains(string: "fix"))
        XCTAssertTrue(trie.contains(string: "fixed"))
        XCTAssertTrue(trie.contains(string: "fixing"))
    }
    
    func testAddExtendedForms_RemoveOne_ContainsOthersIsTrue() {
        
        trie.add(string: "Fix")
        trie.add(string: "Fixed")
        trie.add(string: "Fixing")

        trie.remove(string: "Fixed")

        XCTAssertTrue(trie.contains(string: "fix"))
        XCTAssertTrue(trie.contains(string: "fixing"))
        
        XCTAssertFalse(trie.contains(string: "fixed"))

    }
    
    func testStrings_ReturnsExpected() {
        
        let expected = ["fix", "fixed", "fixer"]
        expected.addEntries(to: trie)
        let actual = trie.strings()
        
        XCTAssertEqual(expected, actual)
    }
    
    func testStringsWithPrefix_A_ReturnsExpected() {
        
        let input = ["a", "abc", "bc", "bob"]
        input.addEntries(to: trie)
        
        let actual = trie.strings(withPrefix: "a")
        
        XCTAssertEqual(["a", "abc"], actual)
    }

    func testStringsWithPrefix_Bob_ReturnsExpected() {
        
        let input = ["a", "bob", "abc", "bobbing"]
        input.addEntries(to: trie)
        let actual = trie.strings(withPrefix: "bob")
        
        XCTAssertEqual(["bob", "bobbing"], actual)
    }

    func testStringsWithPrefix_MixedCase_ReturnsExpected() {
        
        let input = ["a", "bob", "abc", "bobbing"]
        input.addEntries(to: trie)
        let actual = trie.strings(withPrefix: "BoB")
        
        XCTAssertEqual(["bob", "bobbing"], actual)
    }
    
    func testStringsWithPrefix_LongerPrefix_ReturnsExpected() {
        
        let input = ["a", "bob", "abc", "bobbing"]
        input.addEntries(to: trie)
        let actual = trie.strings(withPrefix: "bobb")
        
        XCTAssertEqual(["bobbing"], actual)
    }
    
    func testStringsWithPrefix_LongerPrefixMultipleWords_ReturnsExpected() {
        
        let input = ["a", "bob", "abc", "bobbing", "bobbled"]
        input.addEntries(to: trie)
        let actual = trie.strings(withPrefix: "bobb")
        
        XCTAssertEqual(["bobbing", "bobbled"], actual)
    }
    
    func testStringsWithPrefix_EmptyString_ReturnsExpected() {
        
        let expected = ["a", "bob", "abc", "bobbing", "bobbled"].sorted()
        expected.addEntries(to: trie)
        let actual = trie.strings(withPrefix: "")
        
        XCTAssertEqual(expected, actual)
    }
    
    func testStringsWithPrefix_NoString_ReturnsExpected() {
        
        let expected = ["a", "bob", "abc", "bobbing", "bobbled"].sorted()
        expected.addEntries(to: trie)
        let actual = trie.strings()
        
        XCTAssertEqual(expected, actual)
    }
}

