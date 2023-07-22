//
//  ViewController.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/18.
//

import UIKit

class WordsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var WordsTableView: UITableView!
    
    //配列fruitsを設定
    let fruits = ["apple", "orange", "melon", "banana", "pineapple"]
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "単語一覧"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
                let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
                
                // セルに表示する値を設定する
                cell.textLabel!.text = fruits[indexPath.row]
                
                return cell
        //return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toJapanese" {
            if let indexPath = WordsTableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! JapaneseViewController
                // ここで遷移先のビューコントローラにデータを渡します
                destinationController.selectedFruit = fruits[indexPath.row]
            }
        }
    }

    
//    @objc func buttonTapped() {
//        let WordsListViewController = WordsListViewController()
//        self.navigationController?.pushViewController(WordsListViewController, animated: true)
//    }



}

