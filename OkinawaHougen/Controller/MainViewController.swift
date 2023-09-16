//
//  MainViewController.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/22.
//

import UIKit
import GoogleMobileAds

class MainViewController : UIViewController {
    
    var bannerView: GADBannerView!
    
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
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hex: "#33AAE3") // お好きな色に設定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" // これはテスト用のIDまたはAdMobから取得したIDです
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // Add banner to view and set constraints
                view.addSubview(bannerView)
                bannerView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    bannerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Before changing navigation bar color")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        print("After changing navigation bar color")
    }

    
    
    }

