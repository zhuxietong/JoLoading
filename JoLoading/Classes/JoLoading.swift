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

extension String{
    fileprivate var __loc:String{
        return  NSLocalizedString("\(self)", comment: "")
    }
}


public enum LoadResultType {
    case _offLine//未能连接到网络
    case _404//访问不存在
    case _500(code:String)//服务器错误
    case _invalidAuth//登录已失效
    case _needAuth//用户未登录
    case _timeOut//请求超时
    case _error(tip:String,tag:String?)//业务层提示
    case _success(tip:String?)//无错误
    
    public var message:String{
        switch self {
        case ._offLine:
            return "未能连接到网络"
        case ._404:
            return "访问路径不存在404"
        case ._500(code: let code):
            return "服务器错误\(code)"
        case ._timeOut:
            return "请求超时"
        case ._invalidAuth:
            return "登录已失效"
        case ._needAuth:
            return "用户未登录/或登录已失效"
        case ._error(tip: let tip, tag: _):
            return tip
        case ._success(tip:let str):
            return str ?? "获取数据成功"
        }
    }
}

public extension JoLoading
{
    struct Message{
        
        static var load_failed    = "数据加载是失败请稍候再试".__loc
        
        static var link_failed    = "链接失败请稍候再试".__loc
        
        static var app_tag    = ""
        
        static var loading_message = "数据加载中".__loc
    }
   
}

typealias JoLoading_Hand_Block = (_ handID:String)->()


public var DefaultLoading = JoLoadingBase.self


public class _ClickResult{
    public var block:(_:_ClickResult)->Void
    public init(_ action:@escaping(_:_ClickResult)->Void) {
        self.block = action
    }
}

open class JoLoading: UIView {
    
    public var result:_ClickResult? = nil
    public var resultClick:_ClickResult? = nil
    public var taskID:String? = nil
    public var showing = false
    public var image:UIImage? = nil{
        didSet{
            updateImage()
        }
    }
    open func updateImage(){
        
    }
    
    open func loading(message:String,title:String){}
    open func show(message:String,title:String){}
    open func handle(message:String,title:String,button:String,handAction:@escaping ()->Void){}
    open func dismiss(animated:Bool=true){}
    
    
    open func alertResult(result:LoadResultType?,handle:_ClickResult?=nil){
        
        
    }

    

    open func loading(){
        self.loading(message: JoLoading.Message.loading_message, title: JoLoading.Message.app_tag)

    }
    open func failed(){
        self.show(message: JoLoading.Message.app_tag, title: JoLoading.Message.load_failed)

    }
    
    
    open func addAnimation()
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
}


open class JoLoadingBase: JoLoading {
    open override func loading()
    {
        self.loading(message: JoLoading.Message.loading_message, title: JoLoading.Message.app_tag)
        
    }
    
    
    
    open override func failed()
    {
        
        self.titleL.textColor = UIColor.darkText
        
        self.show(message: JoLoading.Message.app_tag, title: JoLoading.Message.load_failed)
    }
    
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

        titleL.textAlignment = NSTextAlignment.center
        
        infoL.numberOfLines = 5
      
        infoL.textAlignment = NSTextAlignment.center
        
        indicator.style = .gray
        
        
        self.addSubview(titleL)
        self.addSubview(imageV)
        self.addSubview(infoL)
        self.addSubview(indicator)
        self.addSubview(button)
        
        
        backgroundColor = .systemBlue
        
        
        let views = ["lable":infoL,"indicator":indicator,"button":button,"imageV":imageV,"titleL":titleL] as [String : Any];
        
        
        self.addConstraint(NSLayoutConstraint(item: infoL, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: infoL, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        
        
        
        self.addConstraint(NSLayoutConstraint(item: indicator, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: infoL, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0))
        
        
        
        self.addConstraint(NSLayoutConstraint(item: indicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: infoL, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
        
        
        let centerX = NSLayoutConstraint(item: infoL, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        centerX.priority = UILayoutPriority.init(750)
        self.addConstraint(centerX)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|->=20-[lable]->=20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|->=50-[lable]->=50-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lable]-15-[button]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[button(36)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[button(120)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        
        self.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        
        button.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
//        button.addTarget(self, action: #selector(JoLoading.handle as (JoLoading) -> () -> ()), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.tag = 1
        
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imageV]-8-[lable]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        self.addConstraint(NSLayoutConstraint(item: imageV, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleL]-8-[imageV]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        
        self.addConstraint(NSLayoutConstraint(item: titleL, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        
        
        
    }
    
    
    @objc open func handleAction()
    {
        self.handBlock()
    }
    
    

    
    open override func loading(message:String,title:String)
    {
        self.button.alpha = 0.0
        self.button.isEnabled = false
        self.addAnimation()
        
        self.titleL.text = "\(title)"
        self.infoL.numberOfLines = 1
        if message.count > 1
        {
            self.infoL.text = ("        \(message)...")
        }
        else{
            self.infoL.text = ("   ")
        }
        self.indicator.startAnimating()
    }
    
    open override func show(message:String,title:String)
    {
        self.button.alpha = 0.0
        self.button.isEnabled = false
        self.addAnimation()
        
        self.titleL.text = "\(title)"
        
        self.indicator.stopAnimating()
        self.infoL.numberOfLines = -1
        self.infoL.text = ("\(message)")
    }
    
    open override func handle(message:String,title:String,button:String,handAction:@escaping ()->Void)
    {
        self.handBlock = handAction
        self.addAnimation()
        self.button.alpha = 1.0
        self.button.isEnabled = true
        self.button.setTitle(button, for: .normal)
        
        self.titleL.text = "\(title)"
        
        self.indicator.stopAnimating()
        self.infoL.numberOfLines = -1
        self.infoL.text = ("\(message)")
        
        
    }
    
    open override func dismiss(animated:Bool=true)
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





