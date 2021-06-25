//
//  BestCollectionViewCell.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit
import Firebase

class MarketItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet var goodsImg: UIImageView!
    @IBOutlet var menu: UILabel!
    @IBOutlet var stamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        borderSet(view: goodsImg)
        
    }

    func borderSet(view: UIImageView) {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 206/255, green: 208/255, blue: 214/255, alpha: 1).cgColor
    }
    
}
