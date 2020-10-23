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

class TrieNodeTests: XCTestCase {

    func testInit_Value_ParentIsNil() {
        let node = TrieNode(with: "a")
        
        XCTAssertNil(node.parent)
    }

    func testInit_Value_ValueIsAsGiven() {
        let node = TrieNode(with: "a")
        
        XCTAssertEqual("a", node.value)
    }

    func testInit_UpperCaseValue_PreservesUpperCase() {
        let node = TrieNode(with: "A")
        
        XCTAssertEqual("A", node.value)
    }

    func testInit_UpperCaseValueIsEqualToLowerCaseValue_ReturnsFalse() {
        let node = TrieNode(with: "A")
        
        XCTAssertNotEqual("a", node.value)
    }
    
    func testInit_Value_HasChildrenIsFalse() {
        let node = TrieNode(with: "a")
        
        XCTAssertFalse(node.hasChildren)
    }

    func testInit_Value_IsTerminatingIsFalse() {
        let node = TrieNode(with: "a")
        
        XCTAssertFalse(node.isTerminating)
    }

    func testInit_IsTerminatingTrue_IsTerminatingIsTrue() {
        let node = TrieNode(with: "a")
        node.isTerminating = true
        
        XCTAssertTrue(node.isTerminating)
    }

    func testInit_CanDeleteIsTrue() {
        let node = TrieNode(with: "a")
        
        XCTAssertTrue(node.canDelete)
    }
    
    func testInit_IsTerminatingTrue_CanDeleteIsFalse() {
        let node = TrieNode(with: "a")
        node.isTerminating = true
        
        XCTAssertFalse(node.canDelete)
    }
    
    func testTrieNode_AddChild_NodeCountIs1() {
        let parent = TrieNode(with: "a")
        TrieNode.make(with: "b", parent: parent)

        XCTAssertEqual(1, parent.children.count)
    }

    func testTrieNode_AddChild_ParentCanDeleteIsFalse() {
        let parent = TrieNode(with: "a")
        TrieNode.make(with: "b", parent: parent)
        
        XCTAssertFalse(parent.canDelete)
    }
    
    func testTrieNode_DeleteChild_NodeHasChildrenIsFalse() {
        let parent = TrieNode(with: "a")
        TrieNode.make(with: "b", parent: parent).delete()

        XCTAssertFalse(parent.hasChildren)
    }
    
    func testTrieNode_DeleteChild_ParentCanDeleteIsTrue() {
        let parent = TrieNode(with: "a")
        TrieNode.make(with: "b", parent: parent).delete()
        
        XCTAssertTrue(parent.canDelete)
    }

    func testTrieNode_ParentIsTerminating_DeleteChild_ParentCanDeleteIsFalse() {
        let parent = TrieNode(with: "a")
        parent.isTerminating = true
        TrieNode.make(with: "b", parent: parent).delete()
        
        XCTAssertFalse(parent.canDelete)
    }

    // MARK: - Retain Cycle Test
    
    func testTrieNode_ReassignParent_ChildNodeDoesNotRetainParent() {
        var parent: TrieNode? = TrieNode(with: "a")
        let child = TrieNode.make(with: "b", parent: parent)
        parent = nil
      
        XCTAssertNil(child.parent)
    }
}
