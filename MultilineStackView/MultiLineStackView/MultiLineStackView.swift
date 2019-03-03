//
//  MultiLineStackView.swift
//  MultilineStackView
//
//  Created by osanai on 2019/02/28.
//  Copyright © 2019年 osanai. All rights reserved.
//

import UIKit

class MultiLineStackView: UIView {

    fileprivate var baseStackView: UIStackView = UIStackView(frame: .zero)
    fileprivate var stackViews: [UIStackView] {
        return baseStackView.arrangedSubviews as! [UIStackView]
    }
    var viewsInStackViews: [UIView] {
        return stackViews.flatMap { $0.arrangedSubviews }
    }
    
    var spacing:(horizontal:CGFloat, vertical:CGFloat) = (0,0)
    
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
        baseStackView.layoutIfNeeded()        
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
        
        if lastStackView.frame.width + view.expectedWidth() + (CGFloat(lastStackView.arrangedSubviews.count) * lastStackView.spacing) < self.frame.width {
            // 収まる
            lastStackView.add(view: view)
        }
        else {
            // 収まらない
            addHorizontalStackView()
            lastStackView.add(view: view)
        }
    }
    
    func removeLast() {
        
        if count <= 0 {
            return
        }
        
        lastStackView.removeLast()
        if lastStackView.count == 0 {
            baseStackView.removeLast()
        }
        
    }
    
    var existStackView: Bool {
        return !baseStackView.arrangedSubviews.isEmpty
    }
    var lastStackView: UIStackView {
        return baseStackView.arrangedSubviews.last as! UIStackView
    }
    
    var horizontalStackViews:[UIStackView] {
        return baseStackView.arrangedSubviews as! [UIStackView]
    }
}

extension MultiLineStackView {
    var views: [UIView] {
        return horizontalStackViews.flatMap { $0.arrangedSubviews }
    }
    func view(of index:Int) -> UIView? {
        if index < count {
            return views[index]
        }
        return nil
    }
    var count: Int {
        return views.count
    }
    var lastView: UIView? {
        return views.last
    }
    var firstView: UIView? {
        return views.first
    }
}

protocol MultiLineStackViewProtocol {
    var expectedWidth2: CGFloat { get }
}

// MARK: UIStackView

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
    var count: Int {
        return self.arrangedSubviews.count
    }
}

// MARK: UIView

extension UIView {
    
    //var expectedWidth: CGFloat {
    func expectedWidth() -> CGFloat {
        
        if self is SampleView {
            return (self as! MultiLineStackViewProtocol).expectedWidth2
        }
        
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
    
    // 親viewにfitさせる
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
        
    }
}

// MARK: String

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
