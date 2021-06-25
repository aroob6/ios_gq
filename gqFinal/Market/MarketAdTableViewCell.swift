//
//  MarketAdTableViewCell.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit

class MarketAdTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var adCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adCollectionView.delegate = self
        adCollectionView.dataSource = self
        
        adCollectionView.showsHorizontalScrollIndicator = false

        let adCollectioncell = UINib(nibName: "MarketadCollectionViewCell", bundle: nil)
        adCollectionView.register(adCollectioncell, forCellWithReuseIdentifier: "MarketadCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let adCollectioncell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketadCollectionViewCell", for: indexPath as IndexPath) as! MarketadCollectionViewCell

        switch indexPath.row {
        case 0:
            adCollectioncell.adImg.image = UIImage(named: "ad1")
        case 1:
            adCollectioncell.adImg.image = UIImage(named: "ad2")
        case 2:
            adCollectioncell.adImg.image = UIImage(named: "ad3")
        default:
            return adCollectioncell
        }
        
        return adCollectioncell
    }
    
}
