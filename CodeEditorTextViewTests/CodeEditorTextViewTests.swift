//
//  CodeEditorTextViewTests.swift
//  CodeEditorTextViewTests
//
//  Created by Ryang Sohn on 2020/03/10.
//  Copyright © 2020 Ryang Sohn. All rights reserved.
//

import XCTest
@testable import CodeEditorTextView

class CodeEditorTextViewTests: XCTestCase {
    var codeData: CodeData!
    let testCode = "print('Hello, world!')"
    
    override func setUp() {
        self.codeData = CodeData(of: testCode)
    }
    
    func testCodeDataConstructor() {
        XCTAssertNotNil(codeData)
        XCTAssertEqual(self.codeData.lines.count, 1)
    }

    func testCodeDataEditLine() {
        let newCode = "# edited"
        self.codeData.editLine(lineNumber: 0, newLineContent: newCode)
        XCTAssertEqual(newCode, self.codeData.dumpString())
    }
    
    func testCodeDataInsertLine() {
        self.codeData.insertNewLine(after: 0)
        XCTAssertEqual(self.codeData.lines[1], "")
        XCTAssertEqual(self.codeData.lines.count, 2)
        self.codeData.insertNewLine(before: 0)
        XCTAssertEqual(self.codeData.lines[0], "")
        XCTAssertEqual(self.codeData.lines.count, 3)
    }
    
    func testCodeBreakLine() {
        let breakPos = testCode.firstIndex(of: "'")!
        self.codeData.breakLine(0, atPos: breakPos)
        XCTAssertEqual(self.codeData.lines.count, 2)
        XCTAssertEqual(self.codeData.lines[0], String(testCode.prefix(upTo: breakPos)))
        XCTAssertEqual(self.codeData.lines[1], String(testCode.suffix(from: breakPos)))
    }
    
    func testCodeDataDeleteLine() {
        self.codeData.insertNewLine(after: 0)
        self.codeData.deleteLine(at: 1)
        XCTAssertEqual(self.codeData.lines.count, 1)
        XCTAssertEqual(self.codeData.lines[0], testCode)
    }
}
