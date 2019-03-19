//
//  GridStackView.swift
//  MultilineStackView
//
//  Created by osanai on 2019/03/19.
//  Copyright © 2019 osanai. All rights reserved.
//

import UIKit

class GridStackView: UIView {

    fileprivate var rowNum: Int!
    fileprivate var columnNum: Int!
    
    fileprivate var baseStackView: UIStackView = UIStackView(frame: .zero)
    fileprivate var stackViews: [UIStackView] {
        return baseStackView.arrangedSubviews as! [UIStackView]
    }
    var viewsInStackViews: [UIView] {
        return stackViews.flatMap { $0.arrangedSubviews }
    }
    
    var delegate: GridStackViewProtocol?
    
    func setup(rowNum:Int, columnNum:Int) {
        self.rowNum = rowNum
        self.columnNum = columnNum
        
        baseStackView.alignment = .leading
        baseStackView.axis = .vertical
        baseStackView.spacing = 1
        self.addSubview(baseStackView)
        baseStackView.bindFrameToSuperviewBounds()
        
        for i in 0..<columnNum {
            addHorizontalStackView(isHeader: i == 0)
        }
        
        self.backgroundColor = UIColor(white: 0.8, alpha: 1)
        self.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }
    
    func addHorizontalStackView(isHeader: Bool) {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        baseStackView.add(view: stackView)
        baseStackView.layoutIfNeeded()
        
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        stackView.spacing = 1
        
        for i in 0..<rowNum {
            addCellToHorizontalStackView(horizontalStackView: stackView, isHeader: isHeader)
        }
    }
    
    func addCellToHorizontalStackView(horizontalStackView: UIStackView, isHeader:Bool) {
        guard let view = delegate?.cell() else {
            return
        }
        view.widthAnchor.constraint(equalToConstant: self.frame.width/CGFloat(columnNum) ).isActive = true
        if isHeader {
            view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        }
        else {
            view.backgroundColor = .white
        }
        horizontalStackView.add(view: view)
        horizontalStackView.layoutIfNeeded()
    }

}

protocol GridStackViewProtocol {
    func cell() -> UIView
}
