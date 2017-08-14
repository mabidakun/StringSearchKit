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

class StringLoaderTests: XCTestCase {

    func testLoadDictionary_EmptyStringFilename_ReturnsEmptyArray() {
        let expected = 0
        let actual = StringLoader.load(fromTextFileNamed: "")
        
        XCTAssertEqual(expected, actual.count)
    }
    
    func testLoadDictionary_Whitespace_ReturnsEmptyArray() {
        let expected = 0
        let actual = StringLoader.load(fromTextFileNamed: " ")
        
        XCTAssertEqual(expected, actual.count)
    }
    
    func testLoadDictionary_NonExistentFilename_ReturnsEmptyArray() {
        let expected = 0
        let actual = StringLoader.load(fromTextFileNamed: "non-existent-filename")
        
        XCTAssertEqual(expected, actual.count)
    }

    func testLoadDictionary_ExistingFilename_ReturnsPopulatedArray() {
        
        let expected = 13
        let actual = StringLoader.load(withFilepath: StringSearchKitTestHelper.exampleFilepath)

        XCTAssertEqual(expected, actual.count)
    }
    
    func testLoadDictionary_Dictionary_FirstItemsIsAsExpected() {
        let expected = "activate"
        let actual = StringLoader.load(withFilepath: StringSearchKitTestHelper.exampleFilepath)
        
        XCTAssertEqual(expected, actual.first)
    }
    
    func testLoadDictionary_Dictionary_LastItemsIsAsExpected() {
        let expected = "region"
        let actual = StringLoader.load(withFilepath: StringSearchKitTestHelper.exampleFilepath)
        
        XCTAssertEqual(expected, actual.last)
    }
}
