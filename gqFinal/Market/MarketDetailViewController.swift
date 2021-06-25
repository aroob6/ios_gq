//
//  MarketDetailViewController.swift
//  gqFinal
//
//  Created by bora on 2021/06/17.
//

import UIKit
import Firebase

class MarketDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var text: String = ""
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch text {
        case "Cafe":
            //tabbar 같이 바뀜 self.title = "text"
            self.navigationItem.title = "카페"
        case "Bakery":
            self.navigationItem.title = "베이커리"
        case "Goods":
            self.navigationItem.title = "편의점"
        default:
            self.navigationItem.title = "text"
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let marketDetailTableViewCell = UINib(nibName: "MarketDetailTableViewCell", bundle: nil)
        tableView.register(marketDetailTableViewCell, forCellReuseIdentifier: "MarketDetailTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch text {
        case "Cafe":
            return 6
        case "Bakery":
            return 4
        case "Goods":
            return 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketDetailTableViewCell") as!
            MarketDetailTableViewCell
        
        switch text {
        case "Cafe":
            getDB(cell: cell, type: "Cafe", row: indexPath.row)
        case "Bakery":
            getDB(cell: cell, type: "Bakery", row: indexPath.row)
        case "Goods":
            getDB(cell: cell, type: "Goods", row: indexPath.row)
        default:
            getDB(cell: cell, type: "Cafe", row: indexPath.row)
        }
        
        return cell
    }
    
    func getDB(cell: MarketDetailTableViewCell, type: String, row: Int) {
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        
        db.collection("MarketList").document(type).getDocument() { (querySnapshot, err) in
            cell.img.sd_imageTransition = .fade //fade-in 효과
            cell.img.sd_setImage(with: storageRef.child(querySnapshot?.get("GoodsImg-" + String(row+1)) as! String))
            cell.menuLabel.text = (querySnapshot?.get("GoodsName-" + String(row+1)) as! String)
            cell.stampLabel.text = String(querySnapshot?.get("Stamp-" + String(row+1)) as! Int) + " 스탬프"
        }
    }
}
