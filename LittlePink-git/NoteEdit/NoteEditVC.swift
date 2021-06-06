//
//  NoteEditVC.swift
//  LittlePink-git
//
//  Created by Mills on 2021/5/29.
//

import UIKit
import YPImagePicker
import SKPhotoBrowser
import AVKit

class NoteEditVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var photos = [UIImage(named: "1")!,UIImage(named: "2")!]
    
//    var videoURL: URL = Bundle.main.url(forResource: "testVideo", withExtension: ".mp4")!
    var videoURL: URL?
    
    var photoCount:Int { photos.count }
    var isVideo:Bool { videoURL != nil }
    
    var textViewIAView: TextViewIAView{ textView.inputAccessoryView as! TextViewIAView }
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        
    }
    
    @IBAction func TFEditBegin(_ sender: Any) {
        titleCountLabel.isHidden = false
        
    }
    
    @IBAction func TFEditEnd(_ sender: Any) {
        titleCountLabel.isHidden = true
        
    }
    
    @IBAction func TFEndOnExit(_ sender: Any) {
    }
    
    @IBAction func TFEditChanged(_ sender: Any) {
        guard titleTextField.markedTextRange == nil else { return }
        if titleTextField.unwrappedText.count > kMaxNoteTitleCount {
            titleTextField.text = String(titleTextField.unwrappedText.prefix(kMaxNoteTitleCount))
            showTextHUD("标题最多输入\(kMaxNoteTitleCount)字哦")
            DispatchQueue.main.async {
                let end = self.titleTextField.endOfDocument
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
            }
        }
        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrappedText.count)"
    }
    //    @IBAction func TFEditChanged(_ sender: Any) {
//        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrappedText.count)"
//    }
}

//extension NoteEditVC:UITextFieldDelegate{
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // range.location--当前输入的字符或者粘贴文本的第一个字符的索引 （输入的文本）
//        // string--当前输入的某个字符或者粘贴的文本
//
//        //限制字符串长度为20，以下情况返回false(即不让输入)：
//        //1-输入的字符或粘贴的文本在整体内容的索引是20的时候（第21个字符不让输）
//        //2-当前输入的字符的长度+粘贴文本的长度超过20时--防止从一开始就一下子粘贴超过20个字符的文文本
//        let  isExceed = (range.location >= kMaxNoteTitleCount || (textField.unwrappedText.count + string.count) > kMaxNoteTitleCount)
//
//        if isExceed {
//            showTextHUD("标题最多输入\(kMaxNoteTitleCount)字哦")
//        }
//
//        return !isExceed
//    }
//
//}

extension NoteEditVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCellID, for: indexPath) as! PhotoCell
        
        cell.imageView.image = photos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            
            photoFooter.addPhotoBtn.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
            
            return photoFooter
        default:
            fatalError("collectionView的footer出问题了")
        }
    }
    
}

extension NoteEditVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isVideo,let videoURL = videoURL {
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoURL)
            present(playerVC, animated: true) {
                playerVC.player?.play()
            }
            return
        }
        
        // 1. create URL Array
        var images = [SKPhoto]()
        
        for photo in photos {
            images.append(SKPhoto.photoWithImage(photo))
        }

        // 2. create PhotoBrowser Instance, and present.
        let browser = SKPhotoBrowser(photos: images,initialPageIndex: indexPath.item)
        browser.delegate = self
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayDeleteButton = true
        present(browser, animated: true, completion: {})
    }
    
}

extension NoteEditVC : SKPhotoBrowserDelegate {
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        photos.remove(at: index)
        photoCollectionView.reloadData()
        reload()
    }
}
 
// MARK: - 监听
extension NoteEditVC{
    @objc private func addPhoto(){
        if photoCount < kMaxPhotoCount {
            var config = YPImagePickerConfiguration()
            
            // MARK: 通用配置
            config.albumName = Bundle.main.appName //存图片进相册App的'我的相簿'里的文件夹名称
            config.screens = [.library] //依次展示相册，拍视频，拍照页面
            
            // MARK: 相册配置
            config.library.defaultMultipleSelection = true //是否可多选
            config.library.maxNumberOfItems = kMaxPhotoCount - photoCount //最大选取照片或视频数
            config.library.spacingBetweenItems = kSpacingBetweenItems //照片缩略图之间的间距
            
            // MARK: - Gallery(多选完后的展示和编辑页面)-画廊
            config.gallery.hidesRemoveButton = false //每个照片或视频右上方是否有删除按钮
            
            let picker = YPImagePicker(configuration: config)
            
            // MARK: 选完或按取消按钮后的异步回调处理（依据配置处理单个或多个）
            picker.didFinishPicking { [unowned picker] items, _ in
  
                for item in items {
                    if case let .photo(photo) = item{
                        self.photos.append(photo.image)
                    }
                }
                self.photoCollectionView.reloadData()
                
                picker.dismiss(animated: true)
            }
            
            present(picker, animated: true)
        } else {
            showTextHUD("最多只能选择\(kMaxPhotoCount)张照片哦")
        }
    }
}

extension NoteEditVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textViewIAView.currnetTextCount = textView.text.count
        textViewIAView.textCountLabel.text = "\(textViewIAView.currnetTextCount)"
    }
}

