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

class Trie {

    private let head = TrieNode(with: "#")

    // MARK: -

    func add(string aString: String) {

        let string = aString.normalized()

        guard string.hasMoreCharacters else {
            return
        }

        var current = head
        string.forEach { (character) in
            if let next = current.children[character] {
                current = next
                return
            }

            current = TrieNode.make(with: character, parent: current)
        }

        current.isTerminating = true
    }

    func add(strings: [String]) {
        strings.forEach { (string) in
            add(string: string)
        }
    }

    func remove(string: String) {
        remove(string: string.normalized(), node: head)
    }

    func contains(string: String) -> Bool {

        var current: TrieNode? = head

        let word = string.normalized()

        for character in word {

            current = current?.children[character]
            if nil == current {
                break
            }
        }

        return current?.isTerminating ?? false
    }

    func strings(withPrefix prefix: String = "") -> [String] {

        let word = prefix.normalizedPrefix()

        guard let (prefixNode, storedPrefix) = node(reaching: word) else {
            return []
        }

        return strings(below: prefixNode, prefix: storedPrefix).sorted()
    }
}

// MARK: -

private extension Trie {

    func remove(string: String, node: TrieNode? = nil) {

        guard let firstChar = string.firstCharacter,
            let current = node?.children[firstChar]
            else {
                return
        }

        let remainingString = string.byChompingHead()

        if !remainingString.hasMoreCharacters, current.isTerminating {
            current.isTerminating = false
        }
        else {
            remove(string: remainingString, node: current)
        }

        if current.canDelete {
            current.delete()
        }
    }

    // Returns the node at the end of `word` and the stored text of that path, which may differ in bytes from `word` (for example a precomposed "é").
    func node(reaching word: String) -> (node: TrieNode, storedPrefix: String)? {

        var current = head
        var storedPrefix: [Character] = []

        for character in word {
            guard let next = current.children[character] else {
                return nil
            }
            current = next
            storedPrefix.append(next.value)
        }

        return (current, String(storedPrefix))
    }

    // Depth-first walk with an explicit stack, so long strings cannot overflow the call stack.
    func strings(below start: TrieNode, prefix: String) -> [String] {

        var results: [String] = []
        var path: [Character] = []
        var pending: [(node: TrieNode, depth: Int)] = [(start, 0)]

        while let (node, depth) = pending.popLast() {

            path.removeLast(path.count - max(depth - 1, 0))
            if depth > 0 {
                path.append(node.value)
            }

            if node.isTerminating {
                results.append(prefix + String(path))
            }

            for child in node.children.values {
                pending.append((child, depth + 1))
            }
        }

        return results
    }
}

extension Trie: StringDictionaryType {}
