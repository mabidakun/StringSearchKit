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

    let node = TrieNode(with: "#");

    func add(string aString: String) {
        
        guard aString.hasMoreCharacters else {
            return
        }
        
        let string = aString.normalized()
        
        var current = self.node
        string.forEach { (character) in
            if let next = current.nodes[character] {
                current = next
                return
            }

            current = TrieNode.make(withCharacter: character, parent: current)
        }
        
        current.isTerminating = true
    }
    
    func add(strings theStrings: [String]) {
        theStrings.forEach { (string) in
            self.add(string: string)
        }
    }

    func remove(string theString: String) {
        remove(string: theString.normalized(), node: node)
    }

    func contains(string aString: String) -> Bool {
        
        var current: TrieNode? = self.node

        let word = aString.normalized()
        
        for character in word {
            
            current = current?.nodes[character]
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
                node: node,
                accumulatedStrings: values)
        
        return values.map { $0 as! String }.sorted()
    }
    
}

fileprivate extension Trie {
    
    func remove(string aString: String, node: TrieNode? = nil) {
        
        guard let firstChar = aString.firstCharacter,
            let current = node?.nodes[firstChar]
            else {
                return
        }
        
        let remainingString = aString.byChompingHead()
        
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
        
        guard let node = node else {
            return
        }
        
        let nodeValue = nil == node.parent ? "" : String(node.value)
        let stringSoFar = "\(accumulatedCharacters)\(nodeValue)"
        if node.isTerminating && stringSoFar.hasPrefix(word){
            accumulatedStrings.add(stringSoFar)
        }
        
        if !prefix.hasMoreCharacters {
            
            for entry in node.nodes {
                strings(withPrefixWord: word,
                        prefix: prefix,
                        node: entry.value,
                        accumulatedCharacters: stringSoFar,
                        accumulatedStrings: accumulatedStrings)
            }
            return
        }
        
        guard let character = prefix.firstCharacter,
            let child = node.nodes[character] else {
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
