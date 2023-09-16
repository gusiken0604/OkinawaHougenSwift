//
//  ViewController.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/18.
//

import UIKit
import RealmSwift

// グローバル変数で検索の状態を管理
var isSearching = false

class WordsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var WordsTableView: UITableView!
    
    let realmService = RealmService()
    
    var words: [Word]?
    var wordsInSection: [[Word]] = []
    var filteredWords: [Word] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UISearchControllerの初期化
            let searchController = UISearchController(searchResultsController: nil)
            
            // 更新のデリゲート設定
            searchController.searchResultsUpdater = self
            
            // 検索バーのプレースホルダー設定
            searchController.searchBar.placeholder = "検索"
            
            // Navigation BarにSearch Barを追加
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        
        WordsTableView.delegate = self
        WordsTableView.dataSource = self
        
        wordsInSection = Array(repeating: [], count: sectionTitles.count) // セクションごとの単語リストの初期化
        
        self.title = "単語一覧"
        let backButton = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        // 透明度を変更しないようにする
       // navigationController?.navigationBar.isTranslucent = false
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hex: "#33AAE3") // お好きな色に設定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        
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
        // 初期状態で全ての単語を表示
            filteredWords = words ?? []
        
        WordsTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
               return isSearching ? filteredWords.count : wordsInSection[section].count
           }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! WordCell
            let word = isSearching ? filteredWords[indexPath.row] : wordsInSection[indexPath.section][indexPath.row]
            cell.hougenLabel.text = convertToKatakana(romaji: word.hougen)
        cell.japaneseLabel.text = convertToKatakana(romaji: word.japanese)// word.japanese
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
                    
                    let selectedWord: Word
                    if isSearching {
                        // 検索中はfilteredWordsから選択された単語を取得
                        selectedWord = filteredWords[indexPath.row]
                    } else {
                        // 検索中でない場合は、通常の配列から選択された単語を取得
                        selectedWord = wordsInSection[indexPath.section][indexPath.row]
                    }
                    
                    // 遷移先に選択された単語を渡す
                    destinationController.selectedWord = selectedWord
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
        //return sectionTitles
//        return isSearching ? nil : sectionTitles.count
        return isSearching ? nil : sectionTitles
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

extension WordsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            isSearching = true
            
            let katakanaSearchText = convertToKatakana(romaji: searchText)
            
            // hougen または japanese が完全に一致するデータをフィルタリング
            filteredWords = words?.filter { word in
                let katakanaWord = convertToKatakana(romaji: word.hougen)
                return katakanaWord == katakanaSearchText || word.japanese == searchText
            } ?? []
        } else {
            isSearching = false
            // 検索文字がない場合は全データを表示
            filteredWords = words ?? []
        }
        
        WordsTableView.reloadData()
    }

    
}
