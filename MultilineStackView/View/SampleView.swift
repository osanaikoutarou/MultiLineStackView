//
//  SampleView.swift
//  MultilineStackView
//
//  Created by 長内幸太郎 on 2019/03/03.
//  Copyright © 2019年 osanai. All rights reserved.
//

import UIKit

class SampleView: UIView {
    weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init coder")
    }
    private func commonInit() {
        let className = String(describing: type(of: self))
        contentView = Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as? UIView
        addSubview(contentView)
        contentView.frame = self.frame
        
        contentView.bindFrameToSuperviewBounds()
    }

    func setup(title: String) {
        label.text = title
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layoutIfNeeded()
        self.layoutIfNeeded()
        contentView.layer.cornerRadius = contentView.frame.height/2
    }
}

extension SampleView: MultiLineStackViewProtocol {
    var calcWidth: CGFloat {
        let labelWidth = label.text!.width(withConstrainedHeight: label.frame.height, font: label.font)
        let left:CGFloat = 10
        let right:CGFloat = 10
        return labelWidth + left + right
    }
}
