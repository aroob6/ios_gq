//
//  MarketViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit
import Firebase

class MarketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var profileImg: UIImageView!
    var goodsImgs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let marketTableViewCell = UINib(nibName: "MarketTableViewCell", bundle: nil)
        tableView.register(marketTableViewCell, forCellReuseIdentifier: "MarketTableViewCell")
        
        let marketAdTableViewCell = UINib(nibName: "MarketAdTableViewCell", bundle: nil)
        tableView.register(marketAdTableViewCell, forCellReuseIdentifier: "MarketAdTableViewCell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let adtableViewCell = tableView.dequeueReusableCell(withIdentifier: "MarketAdTableViewCell") as!
            MarketAdTableViewCell
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "MarketTableViewCell") as!
            MarketTableViewCell
        
        if indexPath.section == 0 {
            return adtableViewCell
        } else {
            
            switch indexPath.row {
            case 0:
                tableViewCell.titleLabel.text = "카페"
                tableViewCell.collectionView.tag = indexPath.row
            case 1:
                tableViewCell.titleLabel.text = "베이커리"
                tableViewCell.collectionView.tag = indexPath.row
            case 2:
                tableViewCell.titleLabel.text = "편의점"
                tableViewCell.collectionView.tag = indexPath.row
            default:
                tableViewCell.titleLabel.text = "카페"
            }
            return tableViewCell
        }
    }

    func getDB() {
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        db.collection("User").document(Auth.auth().currentUser!.uid).getDocument() { (querySnapshot, err) in
            
            let profileImg = querySnapshot?.get("Profile_img") as! String
            let reference = storageRef.child(profileImg)
            self.profileImg.sd_setImage(with: reference)
        }
    }
  
}
