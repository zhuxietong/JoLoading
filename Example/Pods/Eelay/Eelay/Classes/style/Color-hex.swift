//
//  color-hex.swift
//  app
//
//  Created by tong on 16/6/2.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit


public extension String {
    
//    subscript (index: Int) -> Character {
//        return self[self.characters.index(self.startIndex, offsetBy: index)]
//    }
//
//    subscript (range: Range<Int>) -> String {
//        return String(self[self.characters.index(self.startIndex, offsetBy: range.lowerBound)..<self.characters.index(self.startIndex, offsetBy: range.upperBound)])
//    }
    
    public func sub(from:Int,end:Int) -> String {
        let s = self.index(self.startIndex, offsetBy: from)
        let e = self.index(self.startIndex, offsetBy: end)
        
        let subvalues = self[s..<e] // One-sided Slicing
        return String(subvalues)
        
//        return String(self[self.characters.index(self.startIndex, offsetBy: from)..<self.characters.index(self.startIndex, offsetBy: end)])
    }
}

public extension UIColor {
    convenience init(shex hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex
        
        if hex.hasPrefix("#") {
            
            
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index..<hex.endIndex])
 
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                break
                //print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
//            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
