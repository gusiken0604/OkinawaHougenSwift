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
    
    @IBOutlet weak var JapaneseLabel: TopAlignedLabel!
    
    @IBOutlet weak var IdLabel: UILabel!
    var selectedWord: Word?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //HougenLabel.text = selectedWord?.hougen
        // 方言（ローマ字）をカタカナに変換
                if let hougen = selectedWord?.hougen {
                    HougenLabel.text = convertToKatakana(romaji: hougen)
                }
        
        //JapaneseLabel.text = selectedWord?.japanese
        if let japanese = selectedWord?.japanese {
                    JapaneseLabel.text = convertToKatakana(romaji: japanese)
                }
//        if let japanese = selectedWord?.japanese {
//            let lines = japanese.split(separator: "\n").map { "　" + convertToKatakana(romaji: String($0)) }
//            JapaneseLabel.text = lines.joined(separator: "\n")
//        }
        //IdLabel.text = selectedWord?.id.map{String($0)}
        IdLabel.text = "ID: " + String(selectedWord?.id ?? 0)

    }
    
    func convertToKatakana(romaji: String) -> String {
        var katakana = ""
        var index = romaji.startIndex
        while index < romaji.endIndex {
            var found = false
            for length in (1...3).reversed() {
                let endIndex = romaji.index(index, offsetBy: length, limitedBy: romaji.endIndex) ?? index
                if endIndex <= romaji.endIndex {
                    let range = index..<endIndex
                    let key = String(romaji[range])
                    if let value = romajiToKatakana[key], value.rangeOfCharacter(from: CharacterSet(charactersIn: "-]=?")) == nil {
                        katakana += value
                        index = romaji.index(index, offsetBy: length)
                        found = true
                        break
                    }
                }
            }
            if !found {
                let currentCharacter = romaji[index]
                if "'-]=?".contains(currentCharacter) {
                    // 特殊文字の場合、無視する
                } else {
                    katakana += String(currentCharacter)
                }
                index = romaji.index(after: index)
            }
        }
        return katakana
    }
    
}

