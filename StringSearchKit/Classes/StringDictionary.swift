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

import Foundation

public class StringDictionary: StringDictionaryType {
 
    fileprivate let stringStore = Trie()
    
    public init(withStrings strings: [String]) {
        populate(withString: strings)
    }
    
    public init(withTextFileNamed filename: String) {
        populate(fromTextFileNamed: filename)
    }

    public init(withTextFilepath filepath: String) {
        populate(fromTextFilepath: filepath)
    }
    
    public func add(strings theStrings: [String]) {
        stringStore.add(strings: theStrings)
    }
    
    public func add(string aString: String) {
        stringStore.add(string: aString)
    }

    public func contains(string aString: String) -> Bool {
        return stringStore.contains(string: aString)
    }
    
    public func strings(withPrefix prefix: String) -> [String] {
        return stringStore.strings(withPrefix: prefix)
    }
}

fileprivate extension StringDictionary {
    
    func populate(fromTextFileNamed name: String) {
        
        let strings = StringLoader.load(fromTextFileNamed: name)
        populate(withString: strings)
    }

    func populate(fromTextFilepath path: String) {
        
        let strings = StringLoader.load(withFilepath: path)
        populate(withString: strings)
    }
    
    func populate(withString strings: [String]) {
        strings.addEntries(to: stringStore)
    }
}
