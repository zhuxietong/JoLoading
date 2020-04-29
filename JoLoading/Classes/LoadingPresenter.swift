//
//  JoController.swift
//  jotravel
//
//  Created by tong on 16/2/25.
//  Copyright © 2016年 qicaibuluo. All rights reserved.
//

import Foundation
import UIKit
import Eelay


public var LoadingPresenterDefautLoadingClass:JoLoading.Type = JoLoading.self

public protocol LoadingPresenter{
    
    var LoadingPresenterBg:UIView{get}
    
    var LoadingClass:JoLoading.Type {get}
    
    var loadingV: JoLoading {get set}
    
    var jo_contentView: UIView {get}
    
    var loadingPresenterInset:UIEdgeInsets{get}

    
}

private let loadingTag = 18765
private let contentTag = 18764



public extension LoadingPresenter where Self:UIViewController
{
   
    var loadingPresenterInset:UIEdgeInsets{
        get{
               return .zero
        }
    }
    
    
    var LoadingPresenterBg:UIView{get{
        return self.view
        }}
    
    
    var LoadingClass:JoLoading.Type{
        get{
            return LoadingPresenterDefautLoadingClass
        }
    }
    
    var loadingV:JoLoading{
        get{
            
            if let loadI = self.LoadingPresenterBg.viewWithTag(loadingTag) as? JoLoading
            {
                return loadI
            }
            createLoadView()
            let v = self.LoadingPresenterBg.viewWithTag(loadingTag) as! JoLoading
            return v
        }
        set{
            self.LoadingPresenterBg.viewWithTag(loadingTag)?.removeFromSuperview()
            let loadV = newValue
            loadV.tag = loadingTag
            LoadingPresenterBg.insertSubview(loadV, aboveSubview: jo_contentView)
            let inset = loadingPresenterInset
            LoadingPresenterBg.eelay = [
                [loadV,[ee.T.L.B.R,[inset.top,inset.left,-inset.bottom,-inset.right]]]
            ]
            loadV.dismiss(animated: false)
        }
        
    }
    
    var jo_contentView:UIView{
        get{
            
            if let contentV = self.LoadingPresenterBg.viewWithTag(contentTag)
            {
                return contentV
            }
            createLoadView()
            return self.LoadingPresenterBg.viewWithTag(contentTag)!
        }
    }
    
    
    func __insert_jo_contentView(_ contentV:UIView){
        self.LoadingPresenterBg.eelay = [
            [contentV,[ee.T.L.B.R]],
        ]
    }
    
    private func createLoadView(){
        
        
        let contentV = UIView()
        self.LoadingPresenterBg.insertSubview(contentV, at: 0)
        __insert_jo_contentView(contentV)
        
        let loadV = LoadingClass.init()
        self.LoadingPresenterBg.insertSubview(loadV, aboveSubview: contentV)
        let inset = loadingPresenterInset

        LoadingPresenterBg.eelay = [
            [loadV,[ee.T.L.B.R,[inset.top.+900,inset.left.+900,-inset.bottom.+900,-inset.right.+900]]]
        ]
        
        loadV.tag = loadingTag
        contentV.tag = contentTag
        loadV.dismiss(animated: false)
    }
    
}

public extension LoadingPresenter where Self:UIView
{
    
    var LoadingPresenterBg:UIView{get{
        return self
        }}
    
    
    var LoadingClass:JoLoading.Type{
        get{
            return LoadingPresenterDefautLoadingClass
        }
    }
    
    var loadingV:JoLoading{
        get{
            
            if let loadI = self.LoadingPresenterBg.viewWithTag(loadingTag) as? JoLoading
            {
                return loadI
            }
            createLoadView()
            let v = self.LoadingPresenterBg.viewWithTag(loadingTag) as! JoLoading
            return v
        }
        set{
            self.LoadingPresenterBg.viewWithTag(loadingTag)?.removeFromSuperview()
            let loadV = newValue
            loadV.tag = loadingTag
            LoadingPresenterBg.insertSubview(loadV, aboveSubview: jo_contentView)
            let inset = loadingPresenterInset
            LoadingPresenterBg.eelay = [
                [loadV,[ee.T.L.B.R,[inset.top,inset.left,-inset.bottom,-inset.right]]]
            ]
         
            loadV.alpha = 0
            
            //            loadV.dismiss(animated: false)
        }
        
    }

    var jo_contentView:UIView{
        get{
            
            if let contentV = self.LoadingPresenterBg.viewWithTag(contentTag)
            {
                return contentV
            }
            createLoadView()
            return self.LoadingPresenterBg.viewWithTag(contentTag)!
        }
    }
    
    
    func __insert_jo_contentView(_ contentV:UIView){
        self.LoadingPresenterBg.eelay = [
            [contentV,[ee.T.L.B.R]],
        ]
    }
    
    private func createLoadView(){
        
        
        let contentV = UIView()
        self.LoadingPresenterBg.insertSubview(contentV, at: 0)
        __insert_jo_contentView(contentV)
        
        let loadV = LoadingClass.init()
        self.LoadingPresenterBg.insertSubview(loadV, aboveSubview: contentV)
        let inset = loadingPresenterInset
        LoadingPresenterBg.eelay = [
            [loadV,[ee.T.L.B.R,[inset.top.+900,inset.left.+900,-inset.bottom.+900,-inset.right.+900]]]
        ]
        
        loadV.tag = loadingTag
        contentV.tag = contentTag
        //        loadV.dismiss(animated: false)
        loadV.alpha = 0
    }
    
}




