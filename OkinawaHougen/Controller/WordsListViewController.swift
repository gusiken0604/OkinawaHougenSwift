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
        var words: Results<Word>?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "単語一覧"
            
            // Get data from Realm
            words = realmService.read()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return words?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // セルを取得する
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
            
            // セルに表示する値を設定する
            cell.textLabel!.text = words?[indexPath.row].hougen
            
            return cell
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toJapanese" {
                if let indexPath = WordsTableView.indexPathForSelectedRow {
                    let destinationController = segue.destination as! JapaneseViewController
                    // ここで遷移先のビューコントローラにデータを渡します
                    destinationController.selectedWord = words?[indexPath.row].japanese
                }
            }
        }
    }
