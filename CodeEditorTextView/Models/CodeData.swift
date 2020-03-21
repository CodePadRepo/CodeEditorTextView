//
//  CodeData.swift
//  CodeEditorTextView
//
//  Created by Ryang Sohn on 2020/03/21.
//  Copyright © 2020 Ryang Sohn. All rights reserved.
//

open class CodeData {
    private(set) var lines: [String]
    
    public init(of codeText: String) {
        lines = codeText.components(separatedBy: CharacterSet.newlines)
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
}
