//
//  MarketDetailTableViewCell.swift
//  gqFinal
//
//  Created by bora on 2021/06/17.
//

import UIKit

class MarketDetailTableViewCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var stampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        borderSet(view: img)
    }

    func borderSet(view: UIImageView) {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 206/255, green: 208/255, blue: 214/255, alpha: 1).cgColor
    }
}
