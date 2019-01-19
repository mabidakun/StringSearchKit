//
//  Created by Mike O. Abidakun 2019.
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

class String_AdditionsTests: XCTestCase {

    // MARK: - hasMoreCharacters tests
    func testHasMoreCharacters_OneCharacter_ReturnsTrue() {
        XCTAssertTrue("a".hasMoreCharacters)
    }

    func testHasMoreCharacters_EmptyString_ReturnsFalse() {
        XCTAssertFalse("".hasMoreCharacters)
    }
    
    // MARK: - firstCharacter tests

    func testFirstCharacter_EmptyString_ReturnsNil() {
        XCTAssertNil("".firstCharacter)
    }
    
    func testFirstCharacter_A_ReturnsA() {
        let expected: Character = "A"
        let actual = "A".firstCharacter
        XCTAssertEqual(expected, actual)
    }

    func testFirstCharacter_CBA_ReturnsC() {
        let expected: Character = "C"
        let actual = "CBA".firstCharacter
        XCTAssertEqual(expected, actual)
    }
    
    // MARK: - normalized tests
    
    func testNormalized_VALUE_ReturnsLowerCasedValue() {
        let expected = "value"
        let actual = "VALUE".normalized()
        XCTAssertEqual(expected, actual)
    }
    
    func testNormalized_StringWrappedInWhitespace_RemovesWhitespace() {
        let expected = "value"
        let actual = "  VALUE\n\t".normalized()
        XCTAssertEqual(expected, actual)
    }

    // MARK:- byChompingHead tests
    
    func testByChompingHead_EmptyString_ReturnsEmptyString() {
        let expected = ""
        let actual = "".byChompingHead()
        XCTAssertEqual(expected, actual)
    }

    func testByChompingHead_A_ReturnsEmptyString() {
        let expected = ""
        let actual = "A".byChompingHead()
        XCTAssertEqual(expected, actual)
    }

    func testByChompingHead_ABC_ReturnsBC() {
        let expected = "Bc"
        let actual = "ABc".byChompingHead()
        XCTAssertEqual(expected, actual)
    }
}
