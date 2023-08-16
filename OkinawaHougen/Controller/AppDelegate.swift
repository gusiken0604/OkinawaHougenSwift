//
//  AppDelegate.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/18.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //let hougenDB = HougenDB()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //copyRealmFile()
        copyInitialRealmFileIfNeeded()
        
        let config = Realm.Configuration(
            schemaVersion: 4, // 新しいスキーマバージョンを設定
            migrationBlock: { migration, oldSchemaVersion in
                // ここでのマイグレーション処理が必要な場合に記述
            }
        )
        Realm.Configuration.defaultConfiguration = config
        
        // ここで初期化
        do {
            // Realmの初期化
            _ = try Realm()
            
            
        } catch {
            print("Realmの初期化に失敗: \(error)")
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("shift+command+gでパスを貼り付け")
        
        // ここでのデータベースの追加や初期化の処理が必要であれば実行
        //hougenDB.addHougenDB()
        //プロジェクトファイルにコピー
        //copyRealmFile()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    
    private func copyRealmFile() {
        do {
            let realm = try Realm() // 現在のRealmインスタンスを取得
            let destinationURL = URL(fileURLWithPath: "/Users/gushiken/Desktop/Swift/OkinawaHougen/myrealm.realm")
            // 既存のRealmファイルを指定したURLにコピー
            try realm.writeCopy(toFile: destinationURL)
            print("Realmファイルのコピーが成功しました: \(destinationURL.path)")
        } catch {
            print("Realmファイルのコピーに失敗しました: \(error)")
        }
    }
    
    private func copyInitialRealmFileIfNeeded() {
        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
        
        if let initialFileURL = Bundle.main.url(forResource: "myrealm", withExtension: "realm") {
            let fileManager = FileManager.default
            
            if fileManager.fileExists(atPath: defaultRealmPath.path) {
                do {
                    try fileManager.removeItem(at: defaultRealmPath) // 既存のファイルを削除
                    print("既存のRealmファイルを削除しました")
                } catch let error {
                    print("Realmファイルの削除に失敗しました: \(error)")
                }
            }
            do {
                try fileManager.copyItem(at: initialFileURL, to: defaultRealmPath)
                print("初期データのRealmファイルをコピーしました")
            } catch let error {
                print("Realmファイルのコピーに失敗しました: \(error)")
            }
        } else {
            print("初期データのRealmファイルが見つかりませんでした")
        }
    }
    
}

