//
//  UIStackVIew+Utility.swift
//  MultilineStackView
//
//  Created by osanai on 2019/03/19.
//  Copyright © 2019 osanai. All rights reserved.
//

import Foundation
import UIKit

// MARK: UIStackView

extension UIStackView {
    func add(view: UIView) {
        addArrangedSubview(view)
    }
    func removeLast() {
        if let view = arrangedSubviews.last {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    var count: Int {
        return self.arrangedSubviews.count
    }
}
