//
//  Array+Utility.swift
//  MultilineStackView
//
//  Created by osanai on 2019/03/20.
//  Copyright © 2019 osanai. All rights reserved.
//

import Foundation
import UIKit

extension Array where Iterator.Element == CGFloat {
    var sum: CGFloat {
        return self.reduce(0, +)
    }
}
