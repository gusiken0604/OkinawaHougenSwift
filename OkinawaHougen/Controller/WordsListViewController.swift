//
//  ViewController.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/18.
//

import UIKit
import RealmSwift

class WordsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var WordsTableView: UITableView!
    
    let realmService = RealmService()
    
    var words: [Word]?
    var wordsInSection: [[Word]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WordsTableView.delegate = self
        WordsTableView.dataSource = self
        
        wordsInSection = Array(repeating: [], count: sectionTitles.count) // セクションごとの単語リストの初期化
        
        self.title = "単語一覧"
        let backButton = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        let wordsResults = realmService.read()
        
        words = Array(wordsResults).sorted {
            let katakana1 = convertToKatakana(romaji: $0.hougen)
            let katakana2 = convertToKatakana(romaji: $1.hougen)
            return katakana1.localizedCompare(katakana2) == .orderedAscending
        }
        
        for word in words! {
            let katakanaWord = convertToKatakana(romaji: word.hougen)
            let firstCharacter = String(katakanaWord.prefix(1))
            if let index = sectionTitles.firstIndex(of: firstCharacter) {
                wordsInSection[index].append(word)
            }
        }
        
        WordsTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wordsInSection[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! WordCell
        let word = wordsInSection[indexPath.section][indexPath.row]
        // ここでローマ字をカタカナに変換
        cell.hougenLabel.text = convertToKatakana(romaji: word.hougen)
        cell.japaneseLabel.text = convertToKatakana(romaji: word.japanese)
        
        return cell
        
    }
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toJapanese" {
            if let indexPath = WordsTableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! JapaneseViewController
                // ここで遷移先のビューコントローラにデータを渡します
                destinationController.selectedWord = wordsInSection[indexPath.section][indexPath.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
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
    
    // セクションインデックスのタイトルを設定
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    let sectionTitles = ["ア", "イ", "ウ", "エ", "オ", "カ", "キ", "ク", "ケ", "コ", "サ", "シ", "ス", "セ", "ソ", "タ", "チ", "ツ", "テ", "ト", "ナ", "ニ", "ヌ", "ネ", "ノ", "ハ", "ヒ", "フ", "ヘ", "ホ", "マ", "ミ", "ム", "メ", "モ", "ヤ", "ユ", "ヨ", "ラ", "リ", "ル", "レ", "ロ", "ワ", "ヲ", "ン"]
    
    // セクションインデックスタイトルがタップされたときに呼び出される
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionTitles.firstIndex(of: title) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    //セクション名の配列を返す
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
}
