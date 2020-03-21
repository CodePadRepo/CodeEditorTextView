//
//  CodeData.swift
//  CodeEditorTextView
//
//  Created by Ryang Sohn on 2020/03/21.
//  Copyright © 2020 Ryang Sohn. All rights reserved.
//

import UIKit

open class CodeData {
    private(set) var lines: [String]
    
    fileprivate static func processRawText(_ codeText: String) -> [String] {
        return codeText.components(separatedBy: CharacterSet.newlines)
    }
    
    public init(of codeText: String) {
        self.lines = CodeData.processRawText(codeText)
    }
    
    public func editLine(lineNumber: Int, newLineContent: String) {
        lines[lineNumber] = newLineContent
    }
    
    public func insertNewLine(after newlinePos: Int) {
        lines.insert("", at: newlinePos + 1)
    }
    
    public func insertNewLine(before newlinePos: Int) {
        lines.insert("", at: newlinePos)
    }
    
    public func deleteLine(at linePos: Int) {
        lines.remove(at: linePos)
    }
    
    // TODO: Update this function not to get the whole code
    public func updateCode(at range: NSRange, to text: String) {
        let codeText = NSMutableString(string: dumpString())
        codeText.replaceCharacters(in: range, with: text)
        lines = CodeData.processRawText(String(codeText))
    }
    
    public func breakLine(_ linePos: Int, atPos breakIndex: String.Index) {
        let beforeBreak = String(lines[linePos][..<breakIndex])
        let afterBreak = String(lines[linePos][breakIndex...])
        editLine(lineNumber: linePos, newLineContent: beforeBreak)
        insertNewLine(after: linePos)
        editLine(lineNumber: linePos + 1, newLineContent: afterBreak)
    }
    
    public func dumpString() -> String {
        return lines.joined(separator: "\n") // TODO: Support other line endings
    }
    
    public func renderCode(forLanguage languageDef: LanguageDefinition) -> NSAttributedString {
        let rendered = NSMutableAttributedString(string: "")
        var firstLine = true
        for line in lines {
            if firstLine {
                firstLine = false
            } else {
                rendered.append(NSAttributedString(string: "\n"))
            }
            let words = line.components(separatedBy: " ")
            var firstWord = true
            for word in words {
                if firstWord {
                    firstWord = false
                } else {
                    rendered.append(NSAttributedString(string: " "))
                }
                let renderedWord = NSMutableAttributedString(string: word)
                if languageDef.highlights.contains(word) {
                    let range = NSMakeRange(0, word.count)
                    renderedWord.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
                }
                rendered.append(renderedWord)
            }
        }
        return rendered
    }
}
