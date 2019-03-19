//
//  GridStackViewViewController.swift
//  MultilineStackView
//
//  Created by osanai on 2019/03/19.
//  Copyright © 2019 osanai. All rights reserved.
//

import UIKit

class GridStackViewViewController: UIViewController {

    @IBOutlet weak var gridStackView: GridStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gridStackView.delegate = self
        gridStackView.setup(rowNum: 5, columnNum: 5)
        
    }
    


}

extension GridStackViewViewController: GridStackViewProtocol {
    func cell() -> UIView {
        let button = SampleView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.setup(title: "hoge")
        return button
    }
}
