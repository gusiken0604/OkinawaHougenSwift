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


