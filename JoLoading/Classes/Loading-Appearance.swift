//
//  Loading-Appearance.swift
//  JoLoading
//
//  Created by tong on 2017/7/17.
//

import UIKit

class Loading_Appearance: NSObject {

}


extension UIImage{
    public static func image(_ color:UIColor,size:CGSize=CGSize(width: 1, height: 1))  -> UIImage{
        let rect:CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIButton{
    private struct JoLoadingKey {
        static var btColor = "btColor_key"
    }
    
    public var buttonColor: UIColor {
        get {
            if let obj = objc_getAssociatedObject(self, &JoLoadingKey.btColor) as? UIColor
            {
                return obj
            }
            self.buttonColor = .clear
            return .clear
            
        }
        set {
            objc_setAssociatedObject(self, &JoLoadingKey.btColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setBackgroundImage(UIImage.image(newValue), for: UIControlState.normal)
        }
    }
}

extension JoLoading {
    
    //Appearance
    @objc public dynamic var buttonColor: UIColor {
        get {
            return button.buttonColor
        }
        set { button.buttonColor = newValue }
    }
    @objc public dynamic var buttonFont: UIFont {
        get {
            return button.titleLabel?.font ?? UIFont.systemFont(ofSize: 15)
        }
        set {button.titleLabel?.font = newValue}
    }
    
    @objc public dynamic var buttonTitleColor: UIColor {
        get {
            return button.titleColor(for: .normal) ?? .white
        }
        set { button.setTitleColor(newValue, for: .normal) }
    }
    
    @objc public dynamic var titleColor: UIColor {
        get {
            return titleL.textColor ?? .darkText
        }
        set { titleL.textColor = newValue }
    }
    
    @objc public dynamic var titleFont: UIFont {
        get {
            return titleL.font
        }
        set { titleL.font = newValue }
    }
    
    @objc public var messageColor: UIColor {
        get {
            return infoL.textColor ?? .darkText
        }
        set { infoL.textColor = newValue }
    }
    @objc public var messageFont: UIFont {
        get {
            return infoL.font
        }
        set { infoL.font = newValue }
    }
}

