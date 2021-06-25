//
//  RankingTableViewCell.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit

class RankingTableViewCell: UITableViewCell {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var outView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
