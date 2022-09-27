//
//  MyScrollView.swift
//  delegateProxy
//
//  Created by mike on 2022/9/27.
//

import Foundation
import RxSwift
import UIKit


/// 自訂 scrollview DelegateProxy 測試
class MyScrollView: UIScrollView {

    /// 委派代理
    private var delegateProxy =  DelegateProxy()

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = delegateProxy
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        super.delegate = delegateProxy
    }

    /// 複寫 UIScrollView 委派
    override var delegate: UIScrollViewDelegate? {
        get {
            return delegateProxy.userDelegate
        }
        set {
            self.delegateProxy.userDelegate = newValue;
            /* It seems, we don't need this anymore.
            super.delegate = nil
            super.delegate = _delegateProxy
            */
        }
    }

    func viewForZooming() -> UIView? {
        return self.subviews.first
    }
}

// MARK: 委派代理
extension MyScrollView {
    
    /// MyScrollView 專屬委派代理
    class DelegateProxy: NSObject, UIScrollViewDelegate {
        
        weak var userDelegate: UIScrollViewDelegate?

        
        // 呼叫對應方法
        override func responds(to aSelector: Selector!) -> Bool {
            return super.responds(to: aSelector) || userDelegate?.responds(to: aSelector) == true
        }

        // 找不到相對應的方法，會走這道。
        override func forwardingTarget(for aSelector: Selector!) -> Any? {
            
            /// 攔截方法
            if userDelegate?.responds(to: aSelector) == true {
                return userDelegate
            }

            /// 走原生
            return super.forwardingTarget(for: aSelector)
        }
    }
}
