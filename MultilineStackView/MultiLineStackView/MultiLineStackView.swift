//
//  MultiLineStackView.swift
//  MultilineStackView
//
//  Created by osanai on 2019/02/28.
//  Copyright © 2019年 osanai. All rights reserved.
//

import UIKit

class MultiLineStackView: UIView {

    var baseStackView: UIStackView = UIStackView(frame: .zero)
    var stackViews: [UIStackView] {
        return baseStackView.arrangedSubviews as! [UIStackView]
    }
    var views: [UIView] = []
    var viewsInStackViews: [UIView] {
        return stackViews.flatMap { $0.arrangedSubviews }
    }
    
    var automaticHeight: Bool = true
    var lineHeight: CGFloat = 50.0
    var spacing:(horizontal:CGFloat, vertical:CGFloat) = (0,0)
    
//    required init(coder: NSCoder) {
//        super.init(coder: coder)!
//        initialize()
//    }
    
    func setup(horizontalSpacing:CGFloat, verticalSpacing:CGFloat) {
        spacing = (horizontalSpacing, verticalSpacing)
        
        baseStackView.alignment = .leading
        baseStackView.axis = .vertical
        baseStackView.spacing = spacing.vertical
        self.addSubview(baseStackView)
        baseStackView.bindFrameToSuperviewBounds()
        addHorizontalStackView()
    }
    
    func addHorizontalStackView() {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = spacing.horizontal
        baseStackView.add(view: stackView)
    }
    
    func clear() {
        baseStackView.arrangedSubviews.forEach {
            baseStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    func addView(view: UIView) {
        
        if !existStackView {
            addHorizontalStackView()
        }
        
        views.append(view)
        
        if lastStackView.frame.width + view.expectedWidth < self.frame.width {
            // 収まる
            lastStackView.add(view: view)
        }
        else {
            // 収まらない
            addHorizontalStackView()
            lastStackView.add(view: view)
        }
    }
    
    var existStackView: Bool {
        return !baseStackView.arrangedSubviews.isEmpty
    }
    var lastStackView: UIStackView {
        return baseStackView.arrangedSubviews.last as! UIStackView
    }
}

extension UIStackView {
    func add(view: UIView) {
        addArrangedSubview(view)
    }
    func removeLast() {
        if let view = arrangedSubviews.last {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}

extension UIView {
    var expectedWidth: CGFloat {
        if let widthConstraint = constraints.first(where: { $0.firstAttribute == .width }) {
            return widthConstraint.constant
        }
        else {
            if let label = self as? UILabel {
                return label.text?.width(withConstrainedHeight: label.frame.height, font: label.font) ?? 0
            }
            else {
                return frame.size.width
            }
        }
    }
}

extension UIView {
    
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
        
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
