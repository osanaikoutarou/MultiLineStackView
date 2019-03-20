//
//  GridStackViewLabelCellView.swift
//  MultilineStackView
//
//  Created by osanai on 2019/03/20.
//  Copyright © 2019 osanai. All rights reserved.
//

import UIKit

class GridStackViewLabelCellView: UIView {

    @IBOutlet weak var label: UILabel!
    var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func commonInit() {
        let className = String(describing: type(of: self))
        contentView = Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as? UIView
        addSubview(contentView)
        contentView.frame = self.frame
        contentView.backgroundColor = .clear
        contentView.bindFrameToSuperviewBounds()
    }
    
    func setup(text: String) {
        label.text = text
    }
}
