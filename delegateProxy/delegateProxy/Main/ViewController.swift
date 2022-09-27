//
//  ViewController.swift
//  delegateProxy
//
//  Created by mike on 2022/9/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myScrollView: MyScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 註冊自訂委派
        myScrollView.delegate = self

        // Do any additional setup after loading the view.
    }
}


// MARK: 委派註冊
extension ViewController: UIScrollViewDelegate {
    
    // 滑動停止呼叫
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("DelegateProxy scrollViewDidEndDragging 呼叫！！")
    }
}
