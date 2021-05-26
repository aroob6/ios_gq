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
        
        let adCollectioncell = UINib(nibName: "MarketadCollectionViewCell", bundle: nil)
        adCollectionView.register(adCollectioncell, forCellWithReuseIdentifier: "MarketadCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let adCollectioncell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketadCollectionViewCell", for: indexPath as IndexPath) as! MarketadCollectionViewCell

        return adCollectioncell
    }
    
}
