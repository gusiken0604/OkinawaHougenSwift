//
//  Model.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/22.
//

import Foundation
import RealmSwift
import UIKit




class Word: Object {
    @objc dynamic var id = 0
    @objc dynamic var hougen = ""
    @objc dynamic var japanese = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


class RealmService {
    
    private var realm: Realm

    init() {
        print("RealmService")
            let config = Realm.Configuration(
                schemaVersion: 4, // 新しいスキーマバージョンを設定
                migrationBlock: { migration, oldSchemaVersion in
                    // ここでのマイグレーション処理が必要な場合に記述
                }
            )
            
            realm = try! Realm(configuration: config)
        }
    // Add New Word
    func addNewWord(hougen: String, japanese: String) {
        let word = Word()
        let maxId = realm.objects(Word.self).max(ofProperty: "id") as Int? ?? 0
        word.id = maxId + 1
        word.hougen = hougen
        word.japanese = japanese
        create(word: word)
    }

    // Create
    private func create(word: Word) {
        do {
            try realm.write {
                realm.add(word)
            }
        } catch {
            print("Error saving word: \(error)")
        }
    }

    // Read
    func read() -> Results<Word> {
        return realm.objects(Word.self)
    }

    // Update
    func update(word: Word, newHougen: String, newJapanese: String) {
        do {
            try realm.write {
                word.hougen = newHougen
                word.japanese = newJapanese
            }
        } catch {
            print("Error updating word: \(error)")
        }
    }

    // Delete
    func delete(word: Word) {
        do {
            try realm.write {
                realm.delete(word)
            }
        } catch {
            print("Error deleting word: \(error)")
        }
    }
    
  
    
}

class TopAlignedLabel: UILabel {

    override func drawText(in rect:CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width,height: CGFloat.greatestFiniteMagnitude),
                                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                     attributes: [NSAttributedString.Key.font: font!],
                                                                     context: nil).size
            super.drawText(in: CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: ceil(labelStringSize.height)))
        } else {
            super.drawText(in: rect)
        }
    }
}


extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = scanner.string.index(after: scanner.string.startIndex)
        }
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)
        let red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        let green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        let blue = CGFloat(hexNumber & 0x0000ff) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

let romajiToKatakana: [String: String] = [
    "?a": "ア", "a": "ア", "?i": "イ", "i": "イ", "?u": "ウ", "u": "ウ", "?e": "エ", "e": "エ", "?o": "オ", "o": "オ",
    "’a": "ア", "'a": "ア", "’i": "イ", "'i": "イ", "ji": "イ", "’u": "ウ", "'u": "ウ", "wu": "ウ",
    "’e": "エ", "'e": "エ", "’o": "オ", "'o": "オ",
    "ka": "カ", "ki": "キ", "ku": "ク", "ke": "ケ", "ko": "コ",
    "kja": "キャ", "kju": "キュ", "kjo": "キョ", "kwa": "クヮ", "kwi": "クィ", "kwe": "クェ",
    "ga": "ガ", "gi": "ギ", "gu": "グ", "ge": "ゲ", "go": "ゴ", "gja": "ギャ", "gju": "ギュ", "gjo": "ギョ", "gwa": "グヮ", "gwi": "グィ", "gwe": "グェ",
    "sa": "サ", "si": "スィ", "su": "ス", "se": "セ", "so": "ソ", "Sa": "シャ", "Si": "シ", "Su": "シュ", "Se": "シェ", "So": "ショ", "Za": "ザ",
    "Zi": "ズィ", "Zu": "ズ", "Ze": "ゼ", "Zo": "ゾ", "za": "ジャ", "zi": "ジ", "zu": "ジュ", "ze": "ジェ", "zo": "ジョ",
    "ta": "タ", "ti": "ティ", "tu": "トゥ", "te": "テ", "to": "ト", "da": "ダ", "di": "ディ", "du": "ドゥ", "de": "デ", "do": "ド",
    "Ca": "ツァ", "tsa": "ツァ", "Ci": "ツィ", "tsi": "ツィ", "Cu": "ツ", "tsu": "ツ", "Ce": "ツェ", "tse": "ツェ", "Co": "ツォ", "tso": "ツォ",
    "ca": "チャ", "ci": "チ", "cu": "チュ", "ce": "チェ", "co": "チョ",
    "na": "ナ", "ni": "ニ", "nji": "ニ", "nu": "ヌ", "ne": "ネ", "no": "ノ", "nja": "ニャ", "nju": "ニュ", "nje": "ニェ", "njo": "ニョ",
    "ha": "ハ", "he": "ヘ", "ho": "ホ", "hja": "ヒャ", "hi": "ヒ", "hji": "ヒ", "hju": "ヒュ", "hjo": "ヒョ", "hwa": "ファ", "hwi": "フィ", "hu": "フ", "hwu": "フ", "hwe": "フェ", "hwo": "フォ",
    "pa": "パ", "pi": "ピ", "pu": "プ", "pe": "ぺ", "po": "ポ", "pja": "ピャ", "pju": "ピュ", "pjo": "ピョ",
    "ba": "バ", "bi": "ビ", "bu": "ブ", "be": "ベ", "bo": "ボ", "bja": "ビャ", "bju": "ビュ", "bjo": "ビョ",
    "ma": "マ", "mi": "ミ", "mu": "ム", "me": "メ", "mo": "モ", "mja": "ミャ", "mju": "ミュ", "mjo": "ミョ",
    "ja": "ヤ", "ju": "ユ", "je": "イェ", "jo": "ヨ", "?ja": "?ヤ", "?ju": "?ユ", "?je": "?イェ", "?jo": "?ヨ",
    "ra": "ラ", "ri": "リ", "ru": "ル", "re": "レ", "ro": "ロ", "rja": "リャ", "rju": "リュ", "rjo": "リョ",
    "wa": "ワ", "wi": "ウィ", "we": "ウェ", "wo": "ウォ", "?wa": "?ワ", "?wi": "?ウィ", "?we": "?ウェ",
    "Q": "ッ", "N": "ン", "sja": "シャ", "sji": "シ", "sju": "シュ", "sje": "シェ", "sjo": "ショ", "'ja": "ヤ", "'ju": "ユ", "'je": "イェ", "'jo": "ヨ",
    "bwi": "ブィ", "?ma": "ッマ", "?mi": "ッミ", "?mu": "ッム", "?me": "ッメ", "?mo": "ッモ", "?n": "ッン", "?N": "ッン",
    "'wa": "ワ", "'wi": "ウィ", "'wu": "ウ", "'we": "ウェ", "'wo": "ウォ"
]
//let romajiToKatakana: [(String, String)] = [
//    ("ʔa", "ア"), ("a", "ア"), ("ʔi", "イ"), ("i", "イ"), ("ʔu", "ウ"), ("u", "ウ"), ("ʔe", "エ"), ("e", "エ"), ("ʔo", "オ"), ("o", "オ"),
//    ("'a", "’ア"), ("a", "ァア"), ("'i", "’イ"), ("ji", "ィイ"), ("i", "ィイ"), ("'u", "’ウ"), ("u", "ゥウ"), ("wu", "ゥウ"),
//    ("'e", "’エ"), ("e", "ェエ"), ("'o", "’オ"), ("o", "ォオ"),
//    ("ka", "カ"), ("ki", "キ"), ("ku", "ク"), ("ke", "ケ"), ("ko", "コ"),
//    ("kja", "キャ"), ("kju", "キュ"), ("kjo", "キョ"), ("kwa", "クヮ"), ("kwi", "クィ"), ("kwe", "クェ"),
//    ("ɡa", "ガ"), ("ɡi", "ギ"), ("ɡu", "グ"), ("ɡe", "ゲ"), ("ɡo", "ゴ"),
//    ("ɡja", "ギャ"), ("ɡju", "ギュ"), ("ɡjo", "ギョ"), ("ɡwa", "グヮ"), ("ɡwi", "グィ"), ("ɡwe", "グェ"),
//    ("sa", "サ"), ("si", "スィ"), ("su", "ス"), ("se", "セ"), ("so", "ソ"),
//    ("ʃa", "シャ"), ("ʃi", "シ"), ("ʃu", "シュ"), ("ʃe", "シェ"), ("ʃo", "ショ"),
//    ("dza", "ザ"), ("dzi", "ズィ"), ("dzu", "ズ"), ("dze", "ゼ"), ("dzo", "ゾ"),
//    ("dʒa", "ジャ"), ("dʒi", "ジ"), ("dʒu", "ジュ"), ("dʒe", "ジェ"), ("dʒo", "ジョ"),
//    ("ta", "タ"), ("ti", "ティ"), ("tu", "トゥ"), ("te", "テ"), ("to", "ト"),
//    ("da", "ダ"), ("di", "ディ"), ("du", "ドゥ"), ("de", "デ"), ("do", "ド"),
//    ("tsa", "ツァ"), ("tsi", "ツィ"), ("tsu", "ツ"), ("tse", "ツェ"), ("tso", "ツォ"),
//    ("tʃa", "チャ"), ("tʃi", "チ"), ("tʃu", "チュ"), ("tʃe", "チェ"), ("tʃo", "チョ"),
//    ("na", "ナ"), ("ɲi", "ニ"), ("nu", "ヌ"), ("ne", "ネ"), ("no", "ノ"),
//    ("ɲa", "ニャ"), ("ɲu", "ニュ"), ("ɲe", "ニェ"), ("ɲo", "ニョ"),
//    ("ha", "ハ"), ("he", "ヘ"), ("ho", "ホ"),
//    ("ça", "ヒャ"), ("çi", "ヒ"), ("çu", "ヒュ"), ("ço", "ヒョ"),
//    ("ɸa", "ファ"), ("ɸi", "フィ"), ("ɸu", "フ"), ("ɸe", "フェ"), ("ɸo", "フォ"),
//    ("pa", "パ"), ("pi", "ピ"), ("pu", "プ"), ("pe", "ぺ"), ("po", "ポ"),
//    ("pja", "ピャ"), ("pju", "ピュ"), ("pjo", "ピョ"),
//    ("ba", "バ"), ("bi", "ビ"), ("bu", "ブ"), ("be", "ベ"), ("bo", "ボ"),
//    ("bja", "ビャ"), ("bju", "ビュ"), ("bjo", "ビョ"),
//    ("ma", "マ"), ("mi", "ミ"), ("mu", "ム"), ("me", "メ"), ("mo", "モ"),
//    ("mja", "ミャ"), ("mju", "ミュ"), ("mjo", "ミョ"),
//    ("ja", "ヤ"), ("ju", "ユ"), ("je", "イェ"), ("jo", "ヨ"),
//    ("ʔja", "ʔヤ"), ("ʔju", "ʔユ"), ("ʔje", "ʔイェ"), ("ʔjo", "ʔヨ"),
//    ("ɾa", "ラ"), ("ɾi", "リ"), ("ɾu", "ル"), ("ɾe", "レ"), ("ɾo", "ロ"),
//    ("ɾja", "リャ"), ("ɾju", "リュ"), ("ɾjo", "リョ"),
//    ("wa", "ワ"), ("wi", "ウィ"), ("we", "ウェ"), ("wo", "ウォ"),
//                                              ("ʔwa", "ʔワ"), ("ʔwi", "ʔウィ"), ("ʔwe", "ʔウェ")
//                                          ]

//func convertToKatakana(romaji: String) -> String {
//    var katakana = ""
//    var index = romaji.startIndex
//    while index < romaji.endIndex {
//        var found = false
//        for length in (1...3).reversed() { // 最大3文字のローマ字を探索
//            let endIndex = romaji.index(index, offsetBy: length, limitedBy: romaji.endIndex) ?? romaji.endIndex
//            let range = index ..< endIndex
//            let key = String(romaji[range])
//            if let value = romajiToKatakana[key] {
//                katakana += value
//                index = romaji.index(index, offsetBy: length)
//                found = true
//                break
//            }
//        }
//        if !found { // 対応するカタカナがない場合
//            katakana += String(romaji[index])
//            index = romaji.index(after: index)
//        }
//    }
//    return katakana
//}
