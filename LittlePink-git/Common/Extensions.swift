//
//  Extensions.swift
//  LittlePink-git
//
//  Created by Mills on 2021/5/4.
//

import UIKit

import Foundation

extension Bundle{
    var appName: String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String{
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
