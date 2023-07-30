//
//  Japanese.swift
//  OkinawaHougen
//
//  Created by 具志堅 on 2023/07/18.
//

//import Foundation
import UIKit
import RealmSwift

class JapaneseViewController: UIViewController {

    @IBOutlet weak var HougenLabel: UILabel!
    
    @IBOutlet weak var JapaneseLabel: TopAlignedLabel!
    
    var selectedWord: Word?

    
//    class TopAlignedLabel: UILabel {
//
//        override func drawText(in rect:CGRect) {
//            if let stringText = text {
//                let stringTextAsNSString = stringText as NSString
//                let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width,height: CGFloat.greatestFiniteMagnitude),
//                                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
//                                                                         attributes: [NSAttributedString.Key.font: font!],
//                                                                         context: nil).size
//                super.drawText(in: CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: ceil(labelStringSize.height)))
//            } else {
//                super.drawText(in: rect)
//            }
//        }
//    }

        override func viewDidLoad() {
            super.viewDidLoad()

            HougenLabel.text = selectedWord?.hougen
           // HougenLabel.textAlignment = NSTextAlignment.center
            //HougenLabel.font = UIFont.systemFont(ofSize: 12)
            JapaneseLabel.text = selectedWord?.japanese
            //HougenLabel.text = selectedWord
        }

    }
