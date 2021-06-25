//
//  MarketTableViewCell.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit
import Firebase

class MarketTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var detailPage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        let collectionCell = UINib(nibName: "MarketItemCollectionViewCell", bundle: nil)
        collectionView.register(collectionCell, forCellWithReuseIdentifier: "MarketItemCollectionViewCell")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 6
        case 1:
            return 4
        case 2:
            return 6
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketItemCollectionViewCell", for: indexPath as IndexPath) as! MarketItemCollectionViewCell
        switch collectionView.tag {
        case 0:
            getDB(cell: cell, type: "Cafe", row: indexPath.row)
        case 1:
            getDB(cell: cell, type: "Bakery", row: indexPath.row)
        case 2:
            getDB(cell: cell, type: "Goods", row: indexPath.row)
        default:
            return cell
        }
        return cell
    }
    func getDB(cell: MarketItemCollectionViewCell, type: String, row: Int) {
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        db.collection("MarketList").document(type).getDocument() { (querySnapshot, err) in
            cell.goodsImg.sd_imageTransition = .fade //fade-in 효과
            cell.goodsImg.sd_setImage(with: storageRef.child(querySnapshot?.get("GoodsImg-" + String(row+1)) as! String))
            cell.menu.text = (querySnapshot?.get("GoodsName-" + String(row+1)) as! String)
            cell.stamp.text = String(querySnapshot?.get("Stamp-" + String(row+1)) as! Int) + " 스탬프"
        }
    }
}
