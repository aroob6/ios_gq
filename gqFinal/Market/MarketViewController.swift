//
//  MarketViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit
import Firebase

private struct Const {
    static let ImageSizeForLargeState: CGFloat = 34
    static let ImageRightMargin: CGFloat = 16
    static let ImageBottomMarginForLargeState: CGFloat = 8

}

class MarketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var goodsImgs: [String] = []
    let profileImg = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true
        
        //largetitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 34)!]
        
        //largetitle image
        guard let navigationBar = self.navigationController?.navigationBar else { return }
            navigationBar.addSubview(profileImg)
        profileImg.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        profileImg.clipsToBounds = true
        profileImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImg.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                                 constant: -Const.ImageRightMargin),
            profileImg.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                                  constant: -Const.ImageBottomMarginForLargeState),
            profileImg.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            profileImg.widthAnchor.constraint(equalTo: profileImg.heightAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let marketTableViewCell = UINib(nibName: "MarketTableViewCell", bundle: nil)
        tableView.register(marketTableViewCell, forCellReuseIdentifier: "MarketTableViewCell")
        
        let marketAdTableViewCell = UINib(nibName: "MarketAdTableViewCell", bundle: nil)
        tableView.register(marketAdTableViewCell, forCellReuseIdentifier: "MarketAdTableViewCell")
        
        getDB()
        
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
        
        //테이블뷰 셀 클릭시 효과(회색) 제거
        adtableViewCell.selectionStyle = .none
        tableViewCell.selectionStyle = .none
        
        //클릭이벤트
        tableViewCell.detailPage.isUserInteractionEnabled = true
        
        if indexPath.section == 0 {
            return adtableViewCell
        } else {
            switch indexPath.row {
            case 0:
                tableViewCell.titleLabel.text = "카페"
                tableViewCell.collectionView.tag = indexPath.row
                tableViewCell.detailPage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.cafeTapped)))
            case 1:
                tableViewCell.titleLabel.text = "베이커리"
                tableViewCell.collectionView.tag = indexPath.row
                tableViewCell.detailPage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.bakeryTapped)))
            case 2:
                tableViewCell.titleLabel.text = "편의점"
                tableViewCell.collectionView.tag = indexPath.row
                tableViewCell.detailPage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goodsTapped)))
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
            self.profileImg.sd_imageTransition = .fade //fade-in 효과
            self.profileImg.sd_setImage(with: reference)
        }
    }
    
    func typePage(type: String) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MarketDetailViewController") as? MarketDetailViewController {
                vc.text = type // HomeDetailViewController에서 변수 text 접근
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
  
    @objc func cafeTapped() {
        typePage(type: "Cafe")
    }
    @objc func bakeryTapped() {
        typePage(type: "Bakery")
    }
    @objc func goodsTapped() {
        typePage(type: "Goods")
    }
}
