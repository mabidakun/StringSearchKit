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

class TrieNode: CustomStringConvertible {
    
    let value: Character
    var isTerminating = false
    private (set) weak var parent: TrieNode?
    private var nodes: [Character: TrieNode] = [:]
    
    var children: [Character: TrieNode] {
        return nodes
    }
    
    var hasChildren: Bool {
        return !children.isEmpty
    }

    var description: String {
        return "\(value):\(nodes)"
    }
    
    var canDelete: Bool {
        return !isTerminating && nodes.isEmpty
    }
    
    // MARK: -
    
    init(with value: Character, parent: TrieNode? = nil) {
        self.value = value
        self.parent = parent
    }

    func delete() {
        parent?.nodes[value] = nil
    }
    
    @discardableResult static func make(with character: Character, parent: TrieNode?) -> TrieNode {
        
        let childNode = TrieNode(with: character, parent: parent)
        parent?.insert(child: childNode, character: character)
        return childNode
    }
}

// MARK: -

private extension TrieNode {
    func insert(child: TrieNode, character: Character) {
        nodes[character] = child
    }
}
