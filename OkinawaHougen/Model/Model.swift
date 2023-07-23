//
//  Model.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/22.
//

import Foundation
import RealmSwift



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
        realm = try! Realm()
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
