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
