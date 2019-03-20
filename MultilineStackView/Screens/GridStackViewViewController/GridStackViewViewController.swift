//
//  GridStackViewViewController.swift
//  MultilineStackView
//
//  Created by osanai on 2019/03/19.
//  Copyright © 2019 osanai. All rights reserved.
//

import UIKit

class GridStackViewViewController: NotificationsViewController {

    @IBOutlet weak var gridStackView: GridStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gridStackView.delegate = self
        gridStackView.setup(rowNum: 5, columnNum: 5)
        gridStackView.layoutCells()
        gridStackView.layoutIfNeeded()
        
    }
}

extension GridStackViewViewController: GridStackViewProtocol {
    func cell() -> UIView {
        let labelView = GridStackViewLabelCellView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        labelView.setup(text: "hogehogehoge")
        return labelView
    }
    
    var widthWeight: [CGFloat] {
        return [1, 1.5, 2, 3, 1]
    }
    func widthWithWeight(column: Int) -> CGFloat {
        return (widthWeight[column] / widthWeight.sum) * gridStackView.width
    }
    
    func size(row: Int, column: Int) -> CGSize {
        return CGSize(width: widthWithWeight(column: column) , height: 100)
    }
}

extension GridStackViewViewController {
    static func create() -> GridStackViewViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GridStackViewViewController") as? GridStackViewViewController
    }
}
