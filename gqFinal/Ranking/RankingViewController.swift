//
//  RankingViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit
import Firebase

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var gradeString = ""
    var gradeColor: UIColor = UIColor.gray
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: 170, y: 400, width: 50, height: 50) // 위치 크기 조절
        indicator.center = self.view.center
        indicator.color = UIColor.green
        
        indicator.hidesWhenStopped = true // indicator stop일때 화면 숨김
        indicator.style = UIActivityIndicatorView.Style.medium
        
        indicator.stopAnimating()
        return indicator
    }()

    private var service: UserService?
       private var allusers = [stampUser]() {
           didSet {
               DispatchQueue.main.async {
                   self.users = self.allusers
               }
           }
       }
    var users = [stampUser]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicator.stopAnimating()
               }
           }
       }
    
    func loadData() {
           service = UserService()
           service?.get(collectionID: "User") { users in
               self.allusers = users
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.indicator) //indicator 등록
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.clipsToBounds = true
        //largeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 34)!]

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none //셀 줄 지우기
        
        let rankingTopCell = UINib(nibName: "RankingTopTableViewCell", bundle: nil)
        tableView.register(rankingTopCell, forCellReuseIdentifier: "RankingTopTableViewCell")
        
        let rankingCell = UINib(nibName: "RankingTableViewCell", bundle: nil)
        tableView.register(rankingCell, forCellReuseIdentifier: "RankingTableViewCell")
        
        loadData()
        indicator.startAnimating()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    //cell 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return users.count - 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rankingTopCell = tableView.dequeueReusableCell(withIdentifier: "RankingTopTableViewCell") as! RankingTopTableViewCell
        let rankingCell = tableView.dequeueReusableCell(withIdentifier: "RankingTableViewCell") as! RankingTableViewCell
        let storageRef = Storage.storage().reference()
        
        radiusSet(outView: rankingCell.outView)
        radiusSet(outView: rankingTopCell.outView)
        
        //셀 클릭 시 회색 바탕 제거 
        rankingTopCell.selectionStyle = .none
        rankingCell.selectionStyle = .none
        
        if indexPath.section == 0 {
            let gradeCnt = users.first?.stampCount! ?? 0
            
            rank(gradeCnt: gradeCnt)
            
            let reference = storageRef.child(users.first?.profileImg! ?? "asd")
            rankingTopCell.imgView.sd_imageTransition = .fade //fade-in 효과
            rankingTopCell.imgView.sd_setImage(with: reference)
            rankingTopCell.nameLabel.text = users.first?.name
            rankingTopCell.rankLabel.text = "1위. " + String(gradeCnt) + "개"
            rankingTopCell.ratingLabel.text = gradeString
            rankingTopCell.ratingLabel.textColor = gradeColor
            
            return rankingTopCell
        } else {

            let reference = storageRef.child(users[indexPath.row + 1].profileImg ?? "asd")
            rankingCell.imgView.sd_imageTransition = .fade //fade-in 효과
            
//            rankingCell.imgView.sd_setImage(with: reference, placeholderImage: UIImage(named: "")) { img, error, type, url in
//                if error == nil {
//                    self.indicator.stopAnimating()
//                }
//            }
            rankingCell.imgView.sd_setImage(with: reference)
            let gradeCnt = users[indexPath.row + 1].stampCount!
            rank(gradeCnt: gradeCnt)
            rankingCell.nameLabel.text = users[indexPath.row + 1].name
            rankingCell.rankLabel.text = String(indexPath.row + 2) + "위. " + String(gradeCnt) + "개"
            rankingCell.ratingLabel.text = gradeString
            rankingCell.ratingLabel.textColor = gradeColor
            
            return rankingCell
        }
        
    }
    
    func radiusSet(outView: UIView) {
        //둥글게
        outView.layer.cornerRadius = 1
        outView.layer.borderWidth = 1
        outView.layer.borderColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1).cgColor
    }
    
    func rank(gradeCnt: Int) {
        if gradeCnt < 3 {
            gradeString = "브론즈"
            gradeColor = UIColor.gray
        } else if gradeCnt >= 3 && gradeCnt < 7 {
            gradeString = "실버"
            gradeColor = UIColor.gray
        } else if gradeCnt >= 7 && gradeCnt < 10 {
            gradeString = "골드"
            gradeColor = UIColor(red: 242/255, green: 187/255, blue: 37/255, alpha: 1)
        } else if gradeCnt >= 10 && gradeCnt < 15 {
            gradeString = "플래티넘"
            gradeColor = UIColor(red: 2/255, green: 116/255, blue: 188/255, alpha: 1)
        } else if gradeCnt > 15 {
            gradeString = "마스터"
            gradeColor = UIColor.red
        }
    }
}
