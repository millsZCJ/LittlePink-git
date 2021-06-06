//
//  PhotoFooter.swift
//  LittlePink
//
//  Created by 刘军 on 2020/11/30.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
        
    @IBOutlet weak var addPhotoBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addPhotoBtn.layer.borderWidth = 1
        addPhotoBtn.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
}
