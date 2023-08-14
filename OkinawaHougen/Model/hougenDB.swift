//
//  hougenDB.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/27.
//

import Foundation
import RealmSwift

class HougenDB {
    let realmService = RealmService()
    func addHougenDB() {
        let initialWords = [
            ("アイ", "あれつ そうだ!"),
            ("アキサミヨ一", "えつ、 あれつ、 ああ"),
            ("アマ", "あそこ"),
//    




           
        ]
        let sortedWords = initialWords.sorted { $0.0 < $1.0 }
        for (hougen, japanese) in sortedWords {
            if realmService.read().filter("hougen == %@ AND japanese == %@", hougen, japanese).isEmpty {
                realmService.addNewWord(hougen: hougen, japanese: japanese)
            }
        }
    }
}
