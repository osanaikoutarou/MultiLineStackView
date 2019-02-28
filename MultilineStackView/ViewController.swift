//
//  ViewController.swift
//  MultilineStackView
//
//  Created by osanai on 2019/02/28.
//  Copyright © 2019年 osanai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var multiLineStackView: MultiLineStackView!
    @IBOutlet weak var label: UILabel!
    
    var flowView:UIView!
    var selectIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        multiLineStackView.setup(horizontalSpacing: 5, verticalSpacing: 20)
        
        flowView = UIView(frame: .zero)
        flowView.backgroundColor = .orange
        self.view.insertSubview(flowView, belowSubview: multiLineStackView)
    }

    @IBAction func tapped(_ sender: Any) {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        label.text = prefs[Int.random(in: 1 ..< prefs.count)]
//        label.backgroundColor = .yellow
//        label.heightAnchor.constraint(equalToConstant: CGFloat.random(in: 20...35)).isActive = true
//        label.font = UIFont.systemFont(ofSize: CGFloat.random(in: 6...25))
        multiLineStackView.addView(view: label)
        
        multiLineStackView.layoutIfNeeded()
        
        if let v = multiLineStackView.lastView {
            let rect = v.superview?.convert(v.frame, to: self.view)
            self.label.text = "\(rect!)"
            
            if multiLineStackView.count == 1 {
                flowView.frame = rect!
                selectIndex = 0
            }
        }
        
    }

    @IBAction func tapped2(_ sender: Any) {
        selectIndex += 1
        
        if let v = multiLineStackView.view(of: selectIndex) {
            let rect = v.superview?.convert(v.frame, to: self.view)
            flowView.frame = rect!
        }
    }
    
    var prefs:[String] = ["アーカンソー州","アイオワ州","アイダホ州","アラスカ州","アラバマ州","アリゾナ州","イリノイ州","インディアナ州","ウィスコンシン州","ウェストバージニア州","オクラホマ州","オハイオ州","オレゴン州","カリフォルニア州","カンザス州","ケンタッキー州","コネチカット州","コロラド州","サウスカロライナ州","サウスダコタ州","ジョージア州","テキサス州","テネシー州","デラウェア州","ニュージャージー州","ニューハンプシャー州","ニューメキシコ州","ニューヨーク州","ネバダ州","ネブラスカ州","ノースカロライナ州","ノースダコタ州","バージニア州","バーモント州","ハワイ州","フロリダ州","ペンシルベニア州","マサチューセッツ州","ミシガン州","ミシシッピ州","ミネソタ州","ミズーリ州","メイン州","メリーランド州","モンタナ州","ユタ州","ルイジアナ州","ロードアイランド州","ワイオミング州","ワシントン州"]
}


