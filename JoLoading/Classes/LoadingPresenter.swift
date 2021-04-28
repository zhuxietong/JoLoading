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


public var LoadingPresenterDefautLoadingClass:JoLoading.Type = JoLoadingBase.self

public protocol LoadingPresenter{
    
    var LoadingPresenterBg:UIView{get}
    
    var LoadingClass:JoLoading.Type {get}
    
    var loadingV: JoLoading {get set}
    
    var jo_contentView: UIView {get}
    
    var loadingPresenterInset:UIEdgeInsets{get}

    
}

private let loadingTag = 18765
private let contentTag = 18764


extension UIView{
    public func viewForTag_(_ tag:Int) -> UIView?{
        for v in self.subviews {
            if v.tag == tag{
                return v
            }
        }
        return nil
    }
}

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
            
            if let loadI = self.LoadingPresenterBg.viewForTag_(loadingTag) as? JoLoading
            {
                return loadI
            }
            createLoadView()
            let v = self.LoadingPresenterBg.viewForTag_(loadingTag) as! JoLoading
            return v
        }
        set{
            self.LoadingPresenterBg.viewForTag_(loadingTag)?.removeFromSuperview()
            let loadV = newValue
            loadV.tag = loadingTag
            LoadingPresenterBg.insertSubview(loadV, aboveSubview: jo_contentView)
            let inset = loadingPresenterInset
            LoadingPresenterBg.eelay = [
                [loadV,[ee.T.L.B.R,[inset.top.+1000,inset.left.+1000,(-inset.bottom).+1000,(-inset.right).+1000]]]
            ]
            loadV.dismiss(animated: false)
        }
        
    }
    
    var jo_contentView:UIView{
        get{
            
            if let contentV = self.LoadingPresenterBg.viewForTag_(contentTag)
            {
                return contentV
            }
            createLoadView()
            return self.LoadingPresenterBg.viewForTag_(contentTag)!
        }
    }
    
    
    func __insert_jo_contentView(_ contentV:UIView){
        self.LoadingPresenterBg.eelay = [
            [contentV,[ee.T.L.B.R,[0.+1000,0.+1000,0.+1000,0.+1000]]],
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
            [loadV,[ee.T.L.B.R,[inset.top.+1000,inset.left.+1000,-inset.bottom.+1000,-inset.right.+1000]]]
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
            
            if let loadI = self.LoadingPresenterBg.viewForTag_(loadingTag) as? JoLoading
            {
                return loadI
            }
            createLoadView()
            let v = self.LoadingPresenterBg.viewForTag_(loadingTag) as! JoLoading
            return v
        }
        set{
            self.LoadingPresenterBg.viewForTag_(loadingTag)?.removeFromSuperview()
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
            [loadV,[ee.T.L.B.R,[inset.top.+1000,inset.left.+1000,-inset.bottom.+1000,-inset.right.+1000]]]
        ]
        
        loadV.tag = loadingTag
        contentV.tag = contentTag
        //        loadV.dismiss(animated: false)
        loadV.alpha = 0
    }
    
}




