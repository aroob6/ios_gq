//
//  CommunityHomeTableViewCell.swift
//  gqFinal
//
//  Created by bora on 2021/05/20.
//

import UIKit

class CommunityHomeTableViewCell: UITableViewCell {
    
    @IBOutlet var box: UIView!
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var picImg: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        viewSet(view: box)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func viewSet(view: UIView) {
        view.layer.cornerRadius = 10
        
        view.layer.shadowRadius = 5 //그림자크기
        view.layer.shadowColor = UIColor.black.cgColor //그림자색
        view.layer.shadowOffset = CGSize(width: 3, height: 3) //그림자의 시작위치
        view.layer.shadowOpacity = 0.3 //그림자의 불투명도
        
        view.layer.borderColor = UIColor(red: 206/255, green: 208/255, blue: 214/255, alpha: 0.3).cgColor
        
    }
    
}
