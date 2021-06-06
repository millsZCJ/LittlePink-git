//
//  Extensions.swift
//  LittlePink-git
//
//  Created by Mills on 2021/5/4.
//

import UIKit

extension UITextField {
    var unwrappedText:String { text ?? "" }
}

extension UIView {
    @IBInspectable
    var radius: CGFloat {
        get{
            layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
}

extension UIViewController {
    // MARK: - 展示加载框或提示框
    
    // MARK: 加载框--手动隐藏
    
    // MARK: 提示框--自动隐藏
    func showTextHUD(_ title: String, _ subTitle: String? = nil){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text //不指定的话显示菊花和下面配置的文本
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyborad))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyborad(){
        view.endEditing(true)
    }
}

extension Bundle{
    var appName: String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String{
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
    
    // T 泛指某个类型
    // static能修饰class/struct/enum的存储属性、计算属性、方法；class能修饰类的计算属性和方法
    // static修饰的类的方法不能继承；class修饰的类方法可以继承
    //在protocol中要使用static
    static func loadView<T>(fromNib name: String, with type:T.Type) -> T{
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        fatalError("加载\(type)类型的view失败")
    }
    
    /**
     static 性能高
     class
     */
    
}
