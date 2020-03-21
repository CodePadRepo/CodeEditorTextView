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
    let codeData = CodeData(of: "int main() {}")
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        codeEditorTextView.delegate = self
        codeEditorTextView.attributedText = NSAttributedString(string: "")
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        let attributedString = NSMutableAttributedString(string: textView.text)
        let words = textView.text.components(separatedBy: " ")
        
        for word in words {
            if word == "highlight" {
                let range = (attributedString.string as NSString).range(of: word)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
            }
        }
        textView.attributedText = attributedString
    }
}
