//
//  Japanese.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/18.
//

//import Foundation
import UIKit
import RealmSwift

class JapaneseViewController: UIViewController {
    // 選択されたフルーツの名前を格納するためのプロパティ
    @IBOutlet weak var HougenLabel: UILabel!
    
    @IBOutlet weak var JapaneseLabel: UILabel!
    
    //    var selectedFruit: String?
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        // Do any additional setup after loading the view.
    //        // ここで受け取ったデータを使って何かする
    //        // 例：ラベルに選択されたフルーツの名前を表示する
    //        JapaneseLabel.text = selectedFruit
    //    }
    //
    //    // ...その他のメソッドやプロパティ...
    //}
    var selectedWord: String?

        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            // ここで受け取ったデータを使って何かする
            // 例：ラベルに選択された単語の日本語訳を表示する
            HougenLabel.text = selectedWord
        }

        // ...その他のメソッドやプロパティ...
    }
