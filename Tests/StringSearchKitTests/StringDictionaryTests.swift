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

class StringDictionaryTests: XCTestCase {

    private let DictionaryTextFilename = "example-dictionary"
    private var wordDictionary: StringDictionary!

    override func setUp() {
        wordDictionary = StringDictionary(withTextFilepath: StringSearchKitTestHelper.exampleFilepath)
    }

    // MARK:- init
    func testInit_StringsArray_DictionaryContainsExpectedStrings() {
        let strings = ["a", "c", "b"]
        wordDictionary = StringDictionary(withStrings: strings)
        
        XCTAssertEqual(strings.sorted(), wordDictionary.strings(withPrefix: ""))
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
        XCTAssertFalse(wordDictionary.contains(string: "http://www.macsequencediagram.com"))
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
    
    func testAdd_ArrayToExisting_ContainsExpected() {
        XCTAssertTrue(wordDictionary.contains(string: "alt"))
        XCTAssertFalse(wordDictionary.contains(string: "alice"))
        
        wordDictionary.add(strings: ["alice", "bob", "charlie"])
        
        XCTAssertTrue(wordDictionary.contains(string: "alt"))
        XCTAssertTrue(wordDictionary.contains(string: "alice"))
        XCTAssertTrue(wordDictionary.contains(string: "bob"))
        XCTAssertTrue(wordDictionary.contains(string: "charlie"))
    }
    
    // MARK:- Case preservation
    func testInitWithStrings_NotSpecified_PreserveCaseIsFalse() {
        XCTAssertFalse(wordDictionary.preservesCase)
    }
    
    func testInitWithStrings_PreserveCaseFalse_ReturnsFalse() {
        let wordDictionary = StringDictionary(withStrings: [], preserveCase: false)
        XCTAssertFalse(wordDictionary.preservesCase)
    }

    func testInitWithStrings_PreserveCaseTrue_ReturnsTrue() {
        let wordDictionary = StringDictionary(withStrings: [], preserveCase: true)
        XCTAssertTrue(wordDictionary.preservesCase)
    }

    func testInitWithTextFilePath_NotSpecified_PreserveCaseIsFalse() {
        let wordDictionary = StringDictionary(withTextFilepath: StringSearchKitTestHelper.exampleFilepath)
        XCTAssertFalse(wordDictionary.preservesCase)
    }

    func testInitWithTextFilePath_PreserveCaseFalse_ReturnsFalse() {
        let wordDictionary = StringDictionary(withTextFilepath: StringSearchKitTestHelper.exampleFilepath,
                                              preserveCase: false)
        XCTAssertFalse(wordDictionary.preservesCase)
    }

    func testInitWithTextFilePath_PreserveCaseTrue_ReturnsTrue() {
        let wordDictionary = StringDictionary(withTextFilepath: StringSearchKitTestHelper.exampleFilepath,
                                              preserveCase: true)
        XCTAssertTrue(wordDictionary.preservesCase)
    }

    func testInitWithTextFileNamed_NotSpecified_PreserveCaseIsFalse() {
        let wordDictionary = StringDictionary(withTextFileNamed: StringSearchKitTestHelper.exampleTextFileName)
        XCTAssertFalse(wordDictionary.preservesCase)
    }

    func testInitWithTextFileNamed_PreserveCaseFalse_ReturnsFalse() {
        let wordDictionary = StringDictionary(withTextFileNamed: StringSearchKitTestHelper.exampleTextFileName,
                                              preserveCase: false)
        XCTAssertFalse(wordDictionary.preservesCase)
    }

    func testInitWithTextFileNamed_PreserveCaseTrue_ReturnsTrue() {
        let wordDictionary = StringDictionary(withTextFileNamed: StringSearchKitTestHelper.exampleTextFileName,
                                              preserveCase: true)
        XCTAssertTrue(wordDictionary.preservesCase)
    }

    func testInitWithTextFileNamed_InBundle_LoadsStringsFromBundle() {
        let expected = ["deactivate"]
        let wordDictionary = StringDictionary(withTextFileNamed: StringSearchKitTestHelper.exampleTextFileName,
                                              bundle: StringSearchKitTestHelper.exampleBundle)
        let actual = wordDictionary.strings(withPrefix: "de")

        XCTAssertEqual(expected, actual)
    }

    func testAddString_PreservesCase_ReturnsOriginalCase() {
        let expected = ["Act", "Apple"]
        let wordDictionary = StringDictionary(withStrings: ["Act"], preserveCase: true)
        wordDictionary.add(string: "Apple")
        let actual = wordDictionary.strings()

        XCTAssertEqual(expected, actual)
    }

    func testAddStrings_PreservesCase_ReturnsOriginalCase() {
        let expected = ["App", "Apple"]
        let wordDictionary = StringDictionary(withStrings: [], preserveCase: true)
        wordDictionary.add(strings: ["Apple", "App"])
        let actual = wordDictionary.strings()

        XCTAssertEqual(expected, actual)
    }

    func testInitWithStrings_PreservesCase_WhitespaceWrappedString_ReturnsTrimmedOriginalCase() {
        let expected = ["Apple"]
        let wordDictionary = StringDictionary(withStrings: [" Apple\n"], preserveCase: true)
        let actual = wordDictionary.strings()

        XCTAssertEqual(expected, actual)
    }

    func testStringsWithPrefix_TrailingSpace_MatchesOnlyStringsWithThatSpace() {
        let expected = ["new york"]
        let wordDictionary = StringDictionary(withStrings: ["new york", "newark"])
        let actual = wordDictionary.strings(withPrefix: "new ")

        XCTAssertEqual(expected, actual)
    }

    func testStringsWithPrefix_PreservesCase_DottedCapitalI_MatchesPlainI() {
        let expected = ["İstanbul"]
        let wordDictionary = StringDictionary(withStrings: ["İstanbul"], preserveCase: true)
        let actual = wordDictionary.strings(withPrefix: "ist")

        XCTAssertEqual(expected, actual)
    }

    func testStringsWithPrefix_SharpS_MatchesDoubleSAndReturnsLowercasedOriginal() {
        let expected = ["straße"]
        let wordDictionary = StringDictionary(withStrings: ["Straße"])
        let actual = wordDictionary.strings(withPrefix: "STRASS")

        XCTAssertEqual(expected, actual)
    }

    func testContains_SharpS_DoubleS_ReturnsTrue() {
        let wordDictionary = StringDictionary(withStrings: ["Straße"])
        XCTAssertTrue(wordDictionary.contains(string: "STRASSE"))
    }

    func testInitWithStrings_PreservesCase_CaseVariants_ReturnsLastAdded() {
        let expected = ["APPLE"]
        let wordDictionary = StringDictionary(withStrings: ["Apple", "apple", "APPLE"], preserveCase: true)
        let actual = wordDictionary.strings()

        XCTAssertEqual(expected, actual)
    }

    func testInitWithStrings_PreservesCase_LowercaseVariantAddedLast_ReturnsLowercase() {
        let expected = ["apple"]
        let wordDictionary = StringDictionary(withStrings: ["APPLE", "apple"], preserveCase: true)
        let actual = wordDictionary.strings()

        XCTAssertEqual(expected, actual)
    }

    func testInitWithTextFilePath_WhitespaceOnlyLine_IsNotStored() throws {
        let expected = ["act", "app"]
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).txt")
        try "act\n   \napp\n".write(to: fileURL, atomically: true, encoding: .utf8)
        defer { try? FileManager.default.removeItem(at: fileURL) }
        let wordDictionary = StringDictionary(withTextFilepath: fileURL.path)
        let actual = wordDictionary.strings()

        XCTAssertEqual(expected, actual)
    }

    func testContains_PreservesCase_Activate_ReturnsTrue() {
        let wordDictionary = StringDictionary(withStrings: ["Activate"], preserveCase: true)

        XCTAssertTrue(wordDictionary.contains(string: "activate"))
    }

    func testStringsWithPrefix_PreservesCase_Activate_ReturnsActivateInExpectedCase() {
        let expected = ["Activate"]
        let wordDictionary = StringDictionary(withStrings: expected, preserveCase: true)
        let actual = wordDictionary.strings(withPrefix: expected[0])
        
        XCTAssertEqual(expected, actual)
    }
    
    func testStringsWithPrefix_PreservesCase_Par_ReturnsTwoStringsWithExpectedCase() {
        let expected = ["Par", "Participant"]
        let wordDictionary = StringDictionary(withStrings: expected, preserveCase: true)
        let actual = wordDictionary.strings(withPrefix: "par")
        
        XCTAssertEqual(expected, actual)
    }
}

private extension StringDictionaryTests {
    
    func allWords() -> [String] {
        return [
            "activate",
            "alt",
            "as",
            "deactivate",
            "else",
            "end",
            "loop",
            "neg",
            "note",
            "opt",
            "par",
            "participant",
            "region"
        ]
    }
}
