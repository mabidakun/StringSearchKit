//
//  Created by Mike O. Abidakun 2017.
//  Copyright © 2017-Present Mike O. Abidakun. All rights reserved.
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

class StringDictionaryTests: XCTestCase {

    let DictionaryTextFilename = "example-dictionary"
    var wordDictionary: StringDictionary!

    override func setUp() {
        wordDictionary = StringDictionary(withTextFilepath: StringSearchKitTestHelper.exampleFilepath)
    }

    // MARK:- init
    func testInit_StringsArray_DictionaryContainsExpectedStrings() {
        let strings = ["a", "c", "b"]
        wordDictionary = StringDictionary(withStrings: strings)
        
        XCTAssertEqual(strings.sorted(), wordDictionary.strings())
    }
    
    // MARK:- contains
    
    func testContains_Activate_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "activate"))
    }
    
    func testContains_Deactivate_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "deactivate"))
    }
    
    func testContains_Alt_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "alt"))
    }
    
    func testContains_As_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "as"))
    }

    func testContains_Else_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "else"))
    }

    func testContains_End_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "end"))
    }

    func testContains_Loop_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "loop"))
    }

    func testContains_Neg_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "neg"))
    }

    func testContains_Note_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "note"))
    }
    
    func testContains_Opt_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "opt"))
    }
    
    func testContains_Par_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "par"))
    }
    
    func testContains_Participant_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "participant"))
    }
    
    func testContains_Region_ReturnsTrue() {
        XCTAssertTrue(wordDictionary.contains(string: "region"))
    }
    
    func testContains_AddUserString_ReturnsTrue() {
        wordDictionary.add(string: "alice")
        XCTAssertTrue(wordDictionary.contains(string: "alice"))
    }

    func testContains_NotAddedString_ReturnsFalse() {
        XCTAssertFalse(wordDictionary.contains(string: "sequence diagram"))
    }
    
    func testStringsWithPrefix_Par_ReturnsTwoStrings() {
        let expected = ["par", "participant"]
        let actual = wordDictionary.strings(withPrefix: "par")
        
        XCTAssertEqual(expected, actual)
    }
    
    func testStringsWithPrefix_EmptyString_ReturnsAllEntries() {
        let expected = allWords()
        let actual = wordDictionary.strings(withPrefix: "")
        
        XCTAssertEqual(expected, actual)
    }
    
    func testStringsWithPrefix_Whitespace_ReturnsAllEntries() {
        let expected = allWords()
        let actual = wordDictionary.strings(withPrefix: " ")
        
        XCTAssertEqual(expected, actual)
    }

    func testStringsWithPrefix_NoString_ReturnsAllEntries() {
        let expected = allWords()
        let actual = wordDictionary.strings()
        
        XCTAssertEqual(expected, actual)
    }

    fileprivate func allWords() -> [String] {
        return ["activate", "alt", "as", "deactivate", "else", "end", "loop", "neg", "note", "opt", "par", "participant", "region"]
    }
}
