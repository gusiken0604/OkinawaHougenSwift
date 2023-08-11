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

    let hougenDB = HougenDB()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("shift+command+gでパスを貼り付け")
        hougenDB.addHougenDB()

        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
        let bundleRealmPath = Bundle.main.url(forResource: "default", withExtension: "realm")
        
        // ここでスキーマバージョンとマイグレーションを設定
        let config = Realm.Configuration(
            fileURL: defaultRealmPath,
            schemaVersion: 4, // 新しいスキーマバージョンを設定
            migrationBlock: { migration, oldSchemaVersion in
                // ここでのマイグレーション処理が必要な場合に記述
            }
        )
        do {
            // 新しい設定でRealmを初期化
            let realm = try Realm(configuration: config)
        } catch let error as NSError {
            // Realm初期化エラー処理
            print("Error initializing Realm: \(error)")
        }

        
        
        Realm.Configuration.defaultConfiguration = config

        if !FileManager.default.fileExists(atPath: defaultRealmPath.path) {
            do {
                try FileManager.default.copyItem(at: bundleRealmPath!, to: defaultRealmPath)
            } catch let error {
                print("error: \(error)")
            }
        }

        return true
    }

    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//        print("shift+command+gでパスを貼り付け")
//        hougenDB.addHougenDB()
//
//        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
//        let bundleRealmPath = Bundle.main.url(forResource: "default", withExtension: "realm")
//        if !FileManager.default.fileExists(atPath: defaultRealmPath.path) {
//            do {
//                try FileManager.default.copyItem(at: bundleRealmPath!, to: defaultRealmPath)
//            } catch let error {
//                print("error: \(error)")
//            }
//        }
//
//        return true
//    }
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    let realmService = RealmService()
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//
//        addInitialWords()
//
//        // アプリで使用するdefault.realmのパスを取得
//                let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
//                // 初期データが入ったRealmファイルのパスを取得
//                let bundleRealmPath = Bundle.main.url(forResource: "default", withExtension: "realm")
//                // アプリで使用するRealmファイルが存在しない（= 初回利用）場合は、シードファイルをコピーする
//        if !FileManager.default.fileExists(atPath: defaultRealmPath.path) {
//            do {
//                try FileManager.default.copyItem(at: bundleRealmPath!, to: defaultRealmPath)
//            } catch let error {
//                print("error: \(error)")
//            }}
//        // Override point for customization after application launch.
//        return true
//    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    
//    func addInitialWords() {
//            let initialWords = [("hougen1", "japanese1"), ("hougen2", "japanese2"), ("hougen3", "japanese3"), ("hougen4", "japanese4"), ("hougen5", "japanese5")]
//
//            for (hougen, japanese) in initialWords {
//                if realmService.read().filter("hougen == %@ AND japanese == %@", hougen, japanese).isEmpty {
//                    realmService.addNewWord(hougen: hougen, japanese: japanese)
//                }
//            }
//        }


}

