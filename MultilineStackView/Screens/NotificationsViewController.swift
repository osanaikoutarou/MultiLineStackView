//
//  NotificationsViewController.swift
//  MultilineStackView
//
//  Created by osanai on 2019/03/20.
//  Copyright © 2019 osanai. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    var className: String {
        get {
            return String(describing: type(of: self)) // ClassName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: .didCallViewDidLoad, object: className)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .didCallViewWillAppear, object: className)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.post(name: .didCallViewDidAppear, object: className)
    }

}

extension Notification.Name {
    static let didCallViewDidLoad = Notification.Name("didCallViewDidLoad")
    static let didCallViewWillAppear = Notification.Name("didCallViewWillAppear")
    static let didCallViewDidAppear = Notification.Name("didCallViewDidAppear")
}

