//
//  MainViewController.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/22.
//

import UIKit

class MainViewController : UIViewController {
    
    
    @IBAction func toWrodsListButton(_ sender: Any) {
        }
    
    @IBAction func openGoogleFormButton(_ sender: Any) {
        // このURLは、あなたが作成したGoogleフォームのURLを使用してください。
        if let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSc7TKkqdQfocezbbekE6MuZ1uKyRF-yoSC8RrKk9eqkphrDOA/viewform?usp=pp_url") {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    }
    
//    let WordsListViewController = WordsListViewController()
//    self.navigationController?.pushViewController(WordsListViewController, animated: true)

