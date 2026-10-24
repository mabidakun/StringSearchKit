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

/// A utility class that loads strings from text files.
///
/// `StringLoader` reads newline-delimited text files and returns their
/// contents as an array of strings. It is typically used by
/// ``StringDictionary`` to populate its trie from a file on disk or a
/// bundled text resource.
public class StringLoader {

    /// Loads strings from a text file at the given file path.
    ///
    /// The file is expected to contain one string per line. Any line ending
    /// (`\n`, `\r\n` or `\r`) separates lines, and empty lines are skipped.
    /// Whitespace within a line is kept.
    ///
    /// - Parameter path: The absolute path to the text file.
    /// - Returns: An array of strings, one per non-empty line, or an empty
    ///   array if the file cannot be read.
    public static func load(withFilepath path: String) -> [String] {

        guard let contents = try? String(contentsOfFile: path) else {
            return []
        }

        return contents.split(whereSeparator: \.isNewline).map(String.init)
    }

    /// Loads strings from a named text file resource in a bundle.
    ///
    /// The file is expected to have a `.txt` extension and contain one
    /// string per line. Lines are split as in ``load(withFilepath:)``.
    ///
    /// - Parameters:
    ///   - name: The name of the text file resource, without the `.txt`
    ///     extension.
    ///   - bundle: The bundle that contains the resource. Defaults to the
    ///     main bundle. Pass `Bundle.module` for a resource in a Swift
    ///     package target.
    /// - Returns: An array of strings, one per non-empty line, or an empty
    ///   array if the resource cannot be found or read.
    public static func load(fromTextFileNamed name: String, in bundle: Bundle = .main) -> [String] {

        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let filepath = bundle.path(forResource: name, ofType: .textFileExtension) else {
            return []
        }

        return load(withFilepath: filepath)
    }
}
