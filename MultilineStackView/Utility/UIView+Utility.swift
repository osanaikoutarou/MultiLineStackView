//
//  UIView+Utility.swift
//  MultilineStackView
//
//  Created by 長内幸太郎 on 2019/03/03.
//  Copyright © 2019年 osanai. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func doSomethingAllSuperView(closure:((_ view:UIView) -> Void)) {
        closure(self)
        if let sv = superview {
            sv.doSomethingAllSuperView(closure: closure)
        }
    }
    
    func doSomethingAllSubviews(closure:((_ view:UIView) -> Void)) {
        closure(self)
        subviews.forEach { (view) in
            view.doSomethingAllSubviews(closure: closure)
        }
        
    }
}

extension UIView {
    
    // 親viewにfitさせる
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
        
    }
}
