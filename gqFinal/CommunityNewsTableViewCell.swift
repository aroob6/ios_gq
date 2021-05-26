//
//  CommunityNewsTableViewCell.swift
//  gqFinal
//
//  Created by bora on 2021/05/20.
//

import UIKit

class CommunityNewsTableViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
