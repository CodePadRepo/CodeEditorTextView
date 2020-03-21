//
//  CodeEditorTextView.swift
//  CodeEditorTextView
//
//  Created by Ryang Sohn on 2020/03/10.
//  Copyright © 2020 Ryang Sohn. All rights reserved.
//

import UIKit

open class CodeEditorTextViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var codeEditorTextView: UITextView!
    let codeData = CodeData(of: "")
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        codeEditorTextView.delegate = self
        let renderedString = codeData.renderCode(forLanguage: CLangaugeDef.def)
        dump(renderedString)
        codeEditorTextView.attributedText = codeData.renderCode(forLanguage: CLangaugeDef.def)
        codeEditorTextView.autocorrectionType = .no
        codeEditorTextView.autocapitalizationType = .none
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        codeData.updateCode(at: range, to: text)
        textView.attributedText = codeData.renderCode(forLanguage: CLangaugeDef.def)
        return false
    }
}
