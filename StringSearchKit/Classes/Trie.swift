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
        
        guard aString.hasMoreCharacters else {
            return
        }
        
        let string = aString.normalized()
        
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
        
        let values: NSMutableSet = NSMutableSet()
        
        let word = prefix.normalized()
        strings(withPrefixWord: word,
                prefix: word,
                node: head,
                accumulatedStrings: values)
        
        return
            values
            .compactMap { $0 as? String }
            .sorted()
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
    
    func strings(withPrefixWord word: String,
                 prefix: String,
                 node: TrieNode? = nil,
                 accumulatedCharacters: String = "",
                 accumulatedStrings: NSMutableSet) {
        
        guard let node = node else { return }
        
        let nodeValue = nil == node.parent ? "" : String(node.value)
        let stringSoFar = "\(accumulatedCharacters)\(nodeValue)"
        if node.isTerminating && stringSoFar.hasPrefix(word){
            accumulatedStrings.add(stringSoFar)
        }
        
        if !prefix.hasMoreCharacters {
            
            for entry in node.children {
                strings(withPrefixWord: word,
                        prefix: prefix,
                        node: entry.value,
                        accumulatedCharacters: stringSoFar,
                        accumulatedStrings: accumulatedStrings)
            }
            return
        }
        
        guard let character = prefix.firstCharacter,
            let child = node.children[character] else {
                return
        }
        
        strings(withPrefixWord: word,
                prefix: prefix.byChompingHead(),
                node: child,
                accumulatedCharacters: stringSoFar,
                accumulatedStrings: accumulatedStrings)
    }
}

extension Trie: StringDictionaryType {}
