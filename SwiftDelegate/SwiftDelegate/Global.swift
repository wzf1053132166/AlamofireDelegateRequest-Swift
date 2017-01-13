//
//  Global.swift
//  SwiftDelegate
//
//  Created by wangzhifei on 2017/1/13.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

let NetworkTimeoutTime:Double = 10

let kScreenWidth:CGFloat    = UIScreen.main.bounds.width
let kScreenHeight:CGFloat   = UIScreen.main.bounds.height
let kNavbarHeight:CGFloat   = 64
let TheUserDefaults         = UserDefaults.standard
let kDeviceVersion          = Float(UIDevice.current.systemVersion)
let kTabBarHeight:CGFloat   = 49
let kThemeColor     = UIColor(red: 63.0/255.0, green: 67.0/255.0, blue: 76.0/255.0, alpha: 1.0)

let kBackGroundColor     = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)


// MARK:- 自定义打印方法
func DLog<T>(_ message : T) {
    
    #if true
        
        print("\(message)")
        
    #endif
}


func RGBCOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor
{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

//当前系统版本
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue

//MARK: -颜色方法
func RGBA (_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//MARK: 不透明颜色
func RGBColor (_ r:CGFloat,g:CGFloat,b:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}
