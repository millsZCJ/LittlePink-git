//
//  NoteEditVC-Config.swift
//  LittlePink-git
//
//  Created by Mills on 2021/6/2.
//

import Foundation

extension NoteEditVC {
    
    func config() {
        titleCountLabel.isHidden = true
        hideKeyboardWhenTappedAround()
        
        // MARK: collectionView
        photoCollectionView.dragInteractionEnabled = true //开启拖放交互

        // MARK: titleCountLabel
        titleCountLabel.text = "\(kMaxNoteTitleCount)"
        
        // MARK: textView
        // 去除文本和placeholder的上下左右边距
        let lineFragmentPadding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -lineFragmentPadding, bottom: 0, right: -lineFragmentPadding)
        
        // 行间距
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let typingAttributes: [NSAttributedString.Key:Any] = [
            .paragraphStyle:paragraphStyle,
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.secondaryLabel
        ]
        textView.typingAttributes = typingAttributes
        // 光标颜色
        textView.tintColorDidChange()
        // 软键盘上的view
        textView.inputAccessoryView = Bundle.loadView(fromNib: "TextViewIAView", with: TextViewIAView.self)
        textViewIAView.doneBtn.addTarget(self, action: #selector(resignTextView), for: .touchUpInside)
        textViewIAView.markTextCountLabel.text = "/\(kMaxNoteTextCount)"
        
        //代做 textView字数限制

    }
    
}

// MARK: - 监听
extension NoteEditVC {
    @objc private func resignTextView(){
        guard textView.markedTextRange == nil else { //如果有高亮字符
            return
        }
        textView.resignFirstResponder()
    }
}
