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
        //var words: Results<Word>?
    var words: [Word]?

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // ナビゲーションバーの透明性を無効にする
            //navigationController?.navigationBar.isTranslucent = false
            // レイアウトマージンを調整
//            if let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height {
//                    view.layoutMargins = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
//                }
            //view.layoutMargins = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0)
            self.title = "単語一覧"
            let backButton = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backButton
            
           // words = realmService.read().sorted(byKeyPath: "hougen")
            let wordsResults = realmService.read()
               words = Array(wordsResults).sorted {
                   let katakana1 = convertToKatakana(romaji: $0.hougen)
                   let katakana2 = convertToKatakana(romaji: $1.hougen)
                   return katakana1.localizedCompare(katakana2) == .orderedAscending
               }
            WordsTableView.reloadData()

        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return words?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // セルを取得する
            let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! WordCell
                // セルに表示する値を設定する
                //cell.hougenLabel.text = words?[indexPath.row].hougen
            if let romajiWord = words?[indexPath.row].hougen {
                        cell.hougenLabel.text = convertToKatakana(romaji: romajiWord)
                    }
            
            cell.japaneseLabel.text = words?[indexPath.row].japanese
            //cell.textLabel?.font = UIFont.systemFont(ofSize: 20) // ここでサイズを調節します
            
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
                    //destinationController.selectedWord = words?[indexPath.row].japanese
                    destinationController.selectedWord = words?[indexPath.row]
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



    }
