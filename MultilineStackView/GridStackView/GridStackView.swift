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
        
        for row in 0..<rowNum {
            addRowStackView(row: row)
        }
        
        setupDesign()
    }
    
    private func setupDesign() {
        self.backgroundColor = UIColor(white: 0.8, alpha: 1)
        self.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }
    
    func addRowStackView(row: Int) {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        baseStackView.add(view: stackView)
        baseStackView.layoutIfNeeded()
        
        stackView.widthAnchor.constraint(equalToConstant: baseStackView.frame.width).isActive = true
        
        stackView.spacing = 1
        
        for column in 0..<columnNum {
            addCellToRowStackView(rowStackView: stackView, row: row, column: column)
        }
    }
    
    func addCellToRowStackView(rowStackView: UIStackView, row: Int, column: Int) {
        guard let view = delegate?.cell(for: self, row: row, column: column) else {
            return
        }
        if row == 0 {
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
                if let size = delegate?.size(for: self, row: row, column: column) {
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
    func cell(for gridStackView:GridStackView, row: Int, column: Int) -> UIView
    func size(for gridStackView:GridStackView, row: Int, column: Int) -> CGSize
}
