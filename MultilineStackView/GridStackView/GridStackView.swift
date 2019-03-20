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
            addRowStackView(isHeader: i == 0)
        }
        
        setupDesign()
    }
    
    private func setupDesign() {
        self.backgroundColor = UIColor(white: 0.8, alpha: 1)
        self.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }
    
    func addRowStackView(isHeader: Bool) {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        baseStackView.add(view: stackView)
        baseStackView.layoutIfNeeded()
        
        stackView.widthAnchor.constraint(equalToConstant: baseStackView.frame.width).isActive = true
        
        stackView.spacing = 1
        
        for i in 0..<rowNum {
            addCellToRowStackView(rowStackView: stackView, isHeader: isHeader)
        }
    }
    
    func addCellToRowStackView(rowStackView: UIStackView, isHeader:Bool) {
        guard let view = delegate?.cell() else {
            return
        }
//        view.widthAnchor.constraint(equalToConstant: self.frame.width/CGFloat(columnNum) ).isActive = true
        if isHeader {
            view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        }
        else {
            view.backgroundColor = .white
        }
        rowStackView.add(view: view)
        rowStackView.layoutIfNeeded()
    }
    
    func rowStackView(row: Int) -> UIStackView? {
        return baseStackView.arrangedSubviews[row] as? UIStackView
    }
    
    func cell(row: Int, column: Int) -> UIView? {
        if let rowStackView = baseStackView.arrangedSubviews[row] as? UIStackView {
            return rowStackView.arrangedSubviews[column]
        }
        return nil
    }
    
    func layoutCells() {
        for row in 0..<rowNum {
            for column in 0..<columnNum {
                if let size = delegate?.size(row: row, column: column) {
                    rowStackView(row: row)?.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                    cell(row: row, column: column)?.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                    
                    print("row:\(row) columu:\(column)  size:(\(size)")
                    rowStackView(row: row)?.layoutIfNeeded()
                    baseStackView.layoutIfNeeded()
                }
            }
        }
    }
    
    var width: CGFloat {
        self.superview?.layoutIfNeeded()
        return self.frame.width
    }
    
}

protocol GridStackViewProtocol {
    func cell() -> UIView
    
    func size(row: Int, column:Int) -> CGSize
}
