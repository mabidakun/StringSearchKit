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

public class StringLoader {
    
    public static func load(withFilepath path: String) -> [String] {
        
        guard let contents = try? String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines) else {
            return []
        }
        
        return contents.components(separatedBy: .newlines)
    }

    public static func load(fromTextFileNamed name: String) -> [String] {
        
        guard let contents = loadTextFile(named: name) else {
            return []
        }
        
        return contents.components(separatedBy: .newlines)
    }
}

fileprivate extension StringLoader {
    
    static func loadTextFile(named name: String) -> String? {
        
        guard name.trimmingCharacters(in: .whitespacesAndNewlines).count > 0,
            let filepath = Bundle(for: self).path(forResource: name, ofType: "txt") else {
            return nil
        }

        return try? String(contentsOfFile: filepath).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
