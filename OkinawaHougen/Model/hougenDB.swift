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
        let initialWords = [("aaaa", "japanese1"), ("hougen2", "iiii"), ("hougen3", "japanese3"), ("hougen4", "japanese4"), ("hougen5", "japanese5")]
        
        for (hougen, japanese) in initialWords {
            if realmService.read().filter("hougen == %@ AND japanese == %@", hougen, japanese).isEmpty {
                realmService.addNewWord(hougen: hougen, japanese: japanese)
            }
        }
    }
}
