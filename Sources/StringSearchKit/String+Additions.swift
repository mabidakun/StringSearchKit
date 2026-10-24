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

extension String {

    static let textFileExtension = "txt"

    var hasMoreCharacters: Bool {
        return !isEmpty
    }

    var firstCharacter: Character? {
        return first
    }

    func normalized() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines).caseFolded()
    }

    // Trims leading whitespace with the same character set as normalized(), so prefixes and stored strings agree.
    func normalizedPrefix() -> String {
        let trimmed = unicodeScalars.drop(while: CharacterSet.whitespacesAndNewlines.contains)
        return String(String.UnicodeScalarView(trimmed)).caseFolded()
    }

    // Case folding maps "İ" to "i" plus U+0307; drop the dot so "İstanbul" matches "ist".
    private func caseFolded() -> String {
        return folding(options: .caseInsensitive, locale: nil)
            .replacingOccurrences(of: "i\u{307}", with: "i")
    }

    func byChompingHead() -> String {
        return String(dropFirst())
    }
}
