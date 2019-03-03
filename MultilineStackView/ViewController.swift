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
    
    var selectIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        multiLineStackView.setup(horizontalSpacing: 5, verticalSpacing: 10)

    }

    @IBAction func tapped(_ sender: Any) {
        let button = SampleView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        button.setup(title: samples[Int.random(in: 1 ..< samples.count)])

        button.doSomethingAllSuperView { (view) in
            view.isUserInteractionEnabled = true
        }
        button.doSomethingAllSuperView { (view) in
            view.isUserInteractionEnabled = true
        }
        
        multiLineStackView.addView(view: button)
        
        multiLineStackView.layoutIfNeeded()
        
        if let v = multiLineStackView.lastView {
            let rect = v.superview?.convert(v.frame, to: self.view)
            self.label.text = "\(rect!)"
        }
        
    }
    
    @IBAction func tappedRemove(_ sender: Any) {
        multiLineStackView.removeLast()
    }
    
    var samples:[String] = ["アーカンソー州","アイオワ州","アイダホ州","アラスカ州","アラバマ州","アリゾナ州","イリノイ州","インディアナ州","ウィスコンシン州","ウェストバージニア州","オクラホマ州","オハイオ州","オレゴン州","カリフォルニア州","カンザス州","ケンタッキー州","コネチカット州","コロラド州","サウスカロライナ州","サウスダコタ州","ジョージア州","テキサス州","テネシー州","デラウェア州","ニュージャージー州","ニューハンプシャー州","ニューメキシコ州","ニューヨーク州","ネバダ州","ネブラスカ州","ノースカロライナ州","ノースダコタ州","バージニア州","バーモント州","ハワイ州","フロリダ州","ペンシルベニア州","マサチューセッツ州","ミシガン州","ミシシッピ州","ミネソタ州","ミズーリ州","メイン州","メリーランド州","モンタナ州","ユタ州","ルイジアナ州","ロードアイランド州","ワイオミング州","ワシントン州"]
}


