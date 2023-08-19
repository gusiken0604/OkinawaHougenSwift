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
            let backButton = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backButton

        
            
            // Get data from Realm
           // words = realmService.read()
            // 余白を削除
           // WordsTableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
         //       WordsTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
            words = realmService.read().sorted(byKeyPath: "hougen")
            
            WordsTableView.reloadData()
           // WordsTableView.register(UINib(nibName: "WordCell", bundle: nil), forCellReuseIdentifier: "WordCell")

        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return words?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // セルを取得する
//            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
            
            // セルに表示する値を設定する
           // cell.textLabel!.text = words?[indexPath.row].hougen
            let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as! WordCell
                // セルに表示する値を設定する
                cell.hougenLabel.text = words?[indexPath.row].hougen
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
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return CGFloat.leastNormalMagnitude
//    }

    }
