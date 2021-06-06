//
//  TextViewIAView.swift
//  LittlePink-git
//
//  Created by Mills on 2021/6/6.
//

import UIKit

class TextViewIAView: UIView {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var textCountStackView: UIStackView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var markTextCountLabel: UILabel!
    
    var currnetTextCount = 0{
        didSet {
            if currnetTextCount <= kMaxNoteTextCount {
                doneBtn.isHidden = false
                textCountStackView.isHidden = true
            } else {
                doneBtn.isHidden = true
                textCountStackView.isHidden = false
                textCountLabel.text = "\(currnetTextCount)"
            }
        }
    }
    
}
