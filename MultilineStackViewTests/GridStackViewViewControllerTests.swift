//
//  GridStackViewViewControllerTests.swift
//  MultilineStackViewTests
//
//  Created by osanai on 2019/03/20.
//  Copyright © 2019 osanai. All rights reserved.
//

import XCTest
@testable import MultilineStackView

class GridStackViewViewControllerTests: XCTestCase {

    var gridStackViewViewController:GridStackViewViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        if let vc = GridStackViewViewController.create() {
            gridStackViewViewController = vc
            NotificationCenter.default.addObserver(self, selector: #selector(didCalledViewDidAppear), name: Notification.Name("didCallViewDidAppear"), object: nil)

            gridStackViewViewController.beginAppearanceTransition(true, animated: false)
            gridStackViewViewController.endAppearanceTransition()
            
        }
    }
    
    func didCalledViewDidAppear() {
        print("------")
        print(gridStackViewViewController.widthWithWeight(column: 0))
        print(gridStackViewViewController.widthWithWeight(column: 1))
        print(gridStackViewViewController.widthWithWeight(column: 2))
        print(gridStackViewViewController.widthWithWeight(column: 3))
        print(gridStackViewViewController.widthWithWeight(column: 4))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
