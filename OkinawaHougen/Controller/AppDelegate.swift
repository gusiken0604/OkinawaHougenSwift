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
        
        hougenDB.addHougenDB()

        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
        let bundleRealmPath = Bundle.main.url(forResource: "default", withExtension: "realm")
        if !FileManager.default.fileExists(atPath: defaultRealmPath.path) {
            do {
                try FileManager.default.copyItem(at: bundleRealmPath!, to: defaultRealmPath)
            } catch let error {
                print("error: \(error)")
            }
        }

        return true
    }
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
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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

