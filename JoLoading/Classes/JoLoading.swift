//
//  JoLoadControl.swift
//  MESwiftExtention
//
//  Created by ZHUXIETONG on 15/9/1.
//  Copyright © 2015年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit
import Eelay


public extension JoLoading
{
    private struct Message{
        
        static var load_failed    = "数据加载是失败请稍候再试"
        
        static var link_failed    = "链接失败请稍候再试"
        
        static var app_tag    = ""
    }
    
    public func loading()
    {
        self.loading(message: "数据加载中", title: Message.app_tag)

        
    }
    
    
    
    public func failed()
    {

        self.titleL.textColor = UIColor.darkText
        
        self.show(message: Message.app_tag, title: Message.load_failed)
    }
}

typealias JoLoading_Hand_Block = (_ handID:String)->()


public var DefaultLoading = JoLoading.self


open class JoLoading: UIView {
        
    //    var delegate:MELoadingViewDelegate?
    
    public lazy var titleL:UILabel = {
        let lable = UILabel()
        lable.textColor = UIColor(white: 0.2, alpha: 1.0)
        lable.font = UIFont.systemFont(ofSize: 18)
        return lable
    }()
    
    public var imageV = UIImageView()
    
    public lazy var infoL:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.textColor = UIColor(white: 0.3, alpha: 1.0)
        return lable
    }()
    
    public var indicator = UIActivityIndicatorView()
    
    public lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.buttonColor = UIColor(shex: "#CCC")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()

    
    public var showing = false
    
    
    open var handBlock:()->Void = {
        
        print("press with block")
    }
    
    
    required public init() {
        super.init(frame: .zero)
        self.addLayoutRules()
        
    }
    
    
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func addLayoutRules()
    {
        
        self.backgroundColor = UIColor.white
        
        titleL.translatesAutoresizingMaskIntoConstraints = false
        imageV.translatesAutoresizingMaskIntoConstraints = false
        infoL.translatesAutoresizingMaskIntoConstraints = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        titleL.numberOfLines = 1
//        titleL.textColor = UIColor(white: 0.2, alpha: 1.0)
//        titleL.font = UIFont.systemFont(ofSize: 20)
        titleL.textAlignment = NSTextAlignment.center
        
        infoL.numberOfLines = 5
//        infoL.textColor = UIColor(white: 0.3, alpha: 1.0)
//        infoL.font = UIFont.systemFont(ofSize: 17)
        infoL.textAlignment = NSTextAlignment.center
        
        
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        
        
        self.addSubview(titleL)
        self.addSubview(imageV)
        self.addSubview(infoL)
        self.addSubview(indicator)
        self.addSubview(button)
        
        
        
        
        let views = ["lable":infoL,"indicator":indicator,"button":button,"imageV":imageV,"titleL":titleL] as [String : Any];
        
        
        self.addConstraint(NSLayoutConstraint(item: infoL, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: infoL, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        
        
        self.addConstraint(NSLayoutConstraint(item: indicator, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: infoL, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
        
        
        
        self.addConstraint(NSLayoutConstraint(item: indicator, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: infoL, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        
        
        let centerX = NSLayoutConstraint(item: infoL, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        centerX.priority = UILayoutPriority.init(750)
        self.addConstraint(centerX)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|->=20-[lable]->=20-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|->=50-[lable]->=50-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lable]-15-[button]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[button(36)]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[button(120)]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        
        self.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        button.addTarget(self, action: #selector(JoLoading.handle as (JoLoading) -> () -> ()), for: UIControlEvents.touchUpInside)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.tag = 1
        
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imageV]-8-[lable]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        self.addConstraint(NSLayoutConstraint(item: imageV, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleL]-8-[imageV]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        self.addConstraint(NSLayoutConstraint(item: titleL, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        
        
    }
    
    
    @objc open func handle()
    {
        self.handBlock()
    }
    
    
    private func addAnimation()
    {
        self.showing = true
        if self.showing == false
        {
            self.alpha = 0.0
            self.showing = true
            weak var wself = self

            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                
                wself!.alpha = 1.0
                
            }) { (finish:Bool) -> Void in
            }
        }
        else
        {
            self.alpha = 1.0
            self.showing = true
            
        }
    }
    
    open func loading(message:String,title:String)
    {
        self.button.alpha = 0.0
        self.button.isEnabled = false
        self.addAnimation()
        
        self.titleL.text = "\(title)"
        self.infoL.numberOfLines = 1
        if message.characters.count > 1
        {
            self.infoL.text = ("        \(message)...")
        }
        else{
            self.infoL.text = ("   ")
        }
        self.indicator.startAnimating()
    }
    
    open func show(message:String,title:String)
    {
        self.button.alpha = 0.0
        self.button.isEnabled = false
        self.addAnimation()
        
        self.titleL.text = "\(title)"
        
        self.indicator.stopAnimating()
        self.infoL.numberOfLines = -1
        self.infoL.text = ("\(message)")
    }
    
    open func handle(message:String,title:String,button:String,handAction:@escaping ()->Void)
    {
        self.handBlock = handAction
        self.addAnimation()
        self.button.alpha = 1.0
        self.button.isEnabled = true
        self.button.setTitle(button, for: UIControlState.normal)
        
        self.titleL.text = "\(title)"
        
        self.indicator.stopAnimating()
        self.infoL.numberOfLines = -1
        self.infoL.text = ("\(message)")
        
        
    }
    
    open func dismiss(animated:Bool=true)
    {
        
        
        self.infoL.numberOfLines = 1
        self.infoL.text = ("")
        self.titleL.text = ("")
        
        self.indicator.stopAnimating()
        self.button.alpha = 0.0
        self.button.isEnabled = false
    
        
        if animated
        {
//            weak var wself = self
            UIView.animate(withDuration: 0.34, animations: { () -> Void in
                self.alpha = 0.0
            }) { (finish:Bool) -> Void in
                self.showing = false
            }
        }
        else
        {
            self.alpha = 0.0
            self.showing = false
        }
    }
    
    
   
    
}




