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

    @IBOutlet weak var HougenLabel: UILabel!
    
    @IBOutlet weak var JapaneseLabel: UILabel!
    
    var selectedWord: Word?

        override func viewDidLoad() {
            super.viewDidLoad()

            HougenLabel.text = selectedWord?.hougen
            JapaneseLabel.text = selectedWord?.japanese
            //HougenLabel.text = selectedWord
        }

    }
