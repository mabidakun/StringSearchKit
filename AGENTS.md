# AGENTS.md

StringSearchKit is a small Swift library (macOS 12+, iOS 15+, tvOS 15+, Swift 5.9+) for in-memory, prefix-based string search with a trie. It has no dependencies. It ships through Swift Package Manager (SPM). It also ships through CocoaPods, but CocoaPods Trunk goes read-only on 2026-12-02, so 3.0.0 is the last version published there.

## Commands

- Run all tests: `swift test`
- Run one test class: `swift test --filter TrieTests`
- Run one test: `swift test --filter StringSearchKitTests.TrieTests/<testMethodName>`
- iOS and tvOS builds, as CI runs them (`.github/workflows/ci.yml`, on `macos-26` with Xcode 26.6):
  - `xcodebuild -scheme StringSearchKit -destination 'generic/platform=iOS' build`
  - `xcodebuild -scheme StringSearchKit -destination 'generic/platform=tvOS' build`
- Podspec lint, as CI runs it: `pod lib lint`. Locally it needs a tvOS simulator runtime; without one, `pod lib lint --platforms=macos,ios` checks the other two.

There is no linter or formatter config in the repo.

## Architecture

- `StringDictionary` is the only public entry point apart from `StringLoader`. It wraps an internal `Trie` and adds the optional case preservation.
- `Trie` and `TrieNode` are internal. `Trie` keys every string with `String.normalized()`: trimmed, Unicode case-folded, and with `i` followed by U+0307 mapped to `i`, so `"İstanbul"` matches `"ist"` and `"Straße"` matches `"strasse"`. A prefix goes through `normalizedPrefix()`, which trims only leading whitespace, with the same character set. `strings(withPrefix:)` returns the matching keys sorted, with no duplicates.
- Search (`Trie.strings(below:prefix:)`), removal (`Trie.remove(string:)`) and node freeing (`TrieNode.deinit`) loop instead of recursing. Recursion once per character overflows the stack on background threads for strings of a few thousand characters, so keep them iterative. `TrieNode.deinit` leaves alone any child that something else still holds.
- `StringDictionaryType` is an internal protocol. `Trie` conforms to it. `StringDictionary` has the same method set, so a change to the API must update both.
- Results: `StringDictionary.wordMap` maps a trie key to the string to return. That is the trimmed original when `preserveCase` is `true`, and its `lowercased()` form otherwise, so results never show the case-folded key (`"straße"`, not `"strasse"`). An entry is stored only when it differs from the key. Every `add` updates it. Strings that differ only in case share one key, and the last one added wins.
- `StringLoader` reads files with one string per line. It splits on any line ending (`\r\n` counts as one) and skips empty and whitespace-only lines, but keeps whitespace within a line. `load(fromTextFileNamed:in:)` looks in the bundle that the caller passes, which is `.main` by default. Before 3.0.0 it used `Bundle(for: StringLoader.self)`, which under SPM is not the caller's resource bundle. Do not bring that back. Callers with resources in a Swift package target pass `Bundle.module`.
- Tests load `Tests/StringSearchKitTests/example-dictionary.txt` through `Bundle.module` (declared as a resource in `Package.swift`), in `StringSearchKitTestHelper`.

## Conventions

- Every Swift file starts with the MIT licence header block. Keep it on new files.
- Test names use `test<Unit>_<Condition>_<Expectation>` with `expected` and `actual` locals.
- The release version lives only in `StringSearchKit.podspec` and in git tags. The SPM install snippet in `README.md` names the version too, so update it at a release.
