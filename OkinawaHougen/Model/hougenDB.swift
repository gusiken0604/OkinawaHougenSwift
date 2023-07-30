//
//  hougenDB.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/27.
//

import Foundation
import RealmSwift

class HougenDB {
    let realmService = RealmService()
    func addHougenDB() {
        let initialWords = [
            //以下の単語を("X", "Y"),の形式にする。例えばアップル,りんごだと("アップル","りんご")
//            apple,りんご
//            orange,みかん
            //("X", "Y"), ("hougen2", "iiii"), ("hougen3", "japanese3"), ("hougen4", "japanese4"), ("hougen5", "japanese5")
            ("ゆたさるぐとぅ　うにげーさびら", "よろしくお願いします。ゆたしくも同じ意味だが、新しい言葉。"),
            ("かー", "皮"),
            ("きー", "木"),
            ("がんじゅー", "元気"),
            ("がっぱい", "額"),
            ("ちゃんぷるー", "本来は「料理名」、近年は「混ぜる」という意味で使われている。"),
            ("あさばん", "昼食"),
            ("たび", "旅"),
            ("まーみ", "豆"),
            ("むる", "全部"),
            ("さーたー", "砂糖"),
            ("すーじ", "路地"),
            ("ちゃー", "茶"),
            ("ちー", "血"),
            ("じゃしち", "部屋"),
            ("じー", "土地"),
            ("ない", "実"),
            ("にーさん", "遅い"),
            ("らふてー", "豚の角煮"),
            ("たかさん", "高い"),
            ("てぃー", "手"),
            ("どぅし", "友達"),
            ("はー", "歯"),
            ("ふぃー", "火"),
            ("ふぃーじゃー", "ヤギ"),
            ("わん", "私"),
            ("やー", "家"),
            ("ゆー", "湯"),
            ("くみ", "米"),
            ("くくる", "心"),
            ("くわーし", "菓子"),
            ("くぃー", "声"),
            ("そーぐゎち", "1月"),
            ("ちゃく", "客"),
            ("りゅーちゅー", "琉球"),
            ("ちゅー", "今日"),
            ("んかし", "昔"),
            ("んまが", "孫"),
            ("んむ", "芋"),
            ("さーる", "猿")
        ]
        
        for (hougen, japanese) in initialWords {
            if realmService.read().filter("hougen == %@ AND japanese == %@", hougen, japanese).isEmpty {
                realmService.addNewWord(hougen: hougen, japanese: japanese)
            }
        }
    }
}
