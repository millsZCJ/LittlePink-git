//
//  TabBarC.swift
//  LittlePink-git
//
//  Created by Mills on 2021/5/4.
//

import UIKit
import YPImagePicker

class TabBarC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
    
}

extension TabBarC: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        //待做(判断是否登录)
        
        if viewController is PostVC{
            
            var config = YPImagePickerConfiguration()
            
            // MARK: 通用配置
            config.isScrollToChangeModesEnabled = false //取消滑动切换，防止和编辑相册图片时的手势冲突
            config.onlySquareImagesFromCamera = false //是否只让拍摄正方形照片
            config.albumName = Bundle.main.appName //存图片进相册App的'我的相簿'里的文件夹名称
            config.startOnScreen = .library //一打开就展示相册
            config.screens = [.library, .video, .photo] //依次展示相册，拍视频，拍照页面
            config.maxCameraZoomFactor = kMaxCameraZoomFactor //最大多少倍变焦
            
            // MARK: 相册配置
            config.library.defaultMultipleSelection = true //是否可多选
            config.library.maxNumberOfItems = kMaxPhotoCount //最大选取照片或视频数
            config.library.spacingBetweenItems = kSpacingBetweenItems //照片缩略图之间的间距
            
            // MARK: 视频配置(参照文档,此处全部默认)
            
            // MARK: - Gallery(多选完后的展示和编辑页面)-画廊
            config.gallery.hidesRemoveButton = false //每个照片或视频右上方是否有删除按钮
            
            let picker = YPImagePicker(configuration: config)
            // MARK: 选完或按取消按钮后的异步回调处理（依据配置处理单个或多个）
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled{
//                    print("用户按了左上角的取消按钮")
                }
                
                for item in items {
                    switch item {
                    case .photo(let photo):
                        print(photo)
                    case .video(let video):
                        print(video)
                    }
                }
                
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            
            return false
        }
        
        return true
        
    }
    
}
