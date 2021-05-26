//
//  MarketadCollectionViewCell.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit

class MarketadCollectionViewCell: UICollectionViewCell {

    @IBOutlet var adImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        adImg.layer.cornerRadius = 10
    }

}
