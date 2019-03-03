//
//  UIView+Transform.swift
//  MultilineStackView
//
//  Created by 長内幸太郎 on 2019/03/02.
//  Copyright © 2019年 osanai. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func transform(toFrame:CGRect) -> CGAffineTransform {
        self.layer.anchorPoint = .zero
        let tr = CGAffineTransform(a: toFrame.width/frame.size.width, b: 0, c: 0, d: toFrame.height/frame.size.height, tx: toFrame.origin.x - frame.origin.x, ty: toFrame.origin.y - frame.origin.y)
        self.transform = tr
        return tr
    }
}
