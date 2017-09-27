//
//  ViewController.swift
//  JoLoading
//
//  Created by zhuxietong on 07/17/2017.
//  Copyright (c) 2017 zhuxietong. All rights reserved.
//

import UIKit
import JoLoading
import Eelay


class ViewController: UIViewController,LoadingPresenter {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contentV = UIView()
        jo_contentView.eelay = [
            [contentV,[ee.X.Y],"100",100],
        ]
        contentV.backgroundColor = .brown
    }
    
    @IBAction func start(_ sender: UIBarButtonItem) {
        loadingV.loading()
    }
    @IBAction func hiddenLoading(_ sender: Any) {
        loadingV.dismiss()
    }
    @IBAction func faildLoading(_ sender: Any) {
        loadingV.handle(message: "请检查网络", title: "", button: "重试") {
            print("您点击了重拾")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

