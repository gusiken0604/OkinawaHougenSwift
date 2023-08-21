//
//  MainViewController.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/22.
//

import UIKit

class MainViewController : UIViewController {
    
    
    @IBOutlet weak var toWordsListButton: UIButton!
    @IBAction func toWordsListButton(_ sender: Any) {
        
        }
    
    
    @IBOutlet weak var openGoogleFormButton: UIButton!
    @IBAction func openGoogleFormButton(_ sender: Any) {
        // このURLは、あなたが作成したGoogleフォームのURLを使用してください。
        if let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSc7TKkqdQfocezbbekE6MuZ1uKyRF-yoSC8RrKk9eqkphrDOA/viewform?usp=pp_url") {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let backButton = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backButton
        
        toWordsListButton.layer.borderColor = UIColor(hex: "#33AAE3").cgColor
        toWordsListButton.layer.borderWidth = 2
        toWordsListButton.layer.cornerRadius = 10.0
        
        openGoogleFormButton.layer.cornerRadius = 10.0
        openGoogleFormButton.layer.borderColor = UIColor(hex: "#33AAE3").cgColor
        openGoogleFormButton.layer.borderWidth = 2
    }
    
    
    
    }
    
//    let WordsListViewController = WordsListViewController()
//    self.navigationController?.pushViewController(WordsListViewController, animated: true)

