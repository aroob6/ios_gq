//
//  RakingTableViewCell.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit

class RankingTopTableViewCell: UITableViewCell {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var outView: UIView!
    @IBOutlet var todayText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //날짜 출려
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd(E)"
        let dateString = dateFormatter.string(from: Date())
        todayText.text = dateString
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
