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
    @IBOutlet var todayText: UILabel!
    var gradeString = ""
    var gradeColor: UIColor = UIColor.gray

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

        //날짜 출려
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd(E)"
        let dateString = dateFormatter.string(from: Date())
        todayText.text = dateString

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none //셀 줄 지우기
        
        let rankingTopCell = UINib(nibName: "RankingTopTableViewCell", bundle: nil)
        tableView.register(rankingTopCell, forCellReuseIdentifier: "RankingTopTableViewCell")
        
        let rankingCell = UINib(nibName: "RankingTableViewCell", bundle: nil)
        tableView.register(rankingCell, forCellReuseIdentifier: "RankingTableViewCell")
        
        loadData()
        
        
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
        
        radiusSet(imgView: rankingCell.imgView)
        radiusSet(imgView: rankingTopCell.imgView)
        
       
        
        if indexPath.section == 0 {
            let gradeCnt = users.first?.stampCount! ?? 0
            
            rank(gradeCnt: gradeCnt)
            
            let reference = storageRef.child(users.first?.profileImg! ?? "asd")
            rankingTopCell.imgView.sd_setImage(with: reference)
            rankingTopCell.nameLabel.text = users.first?.name
            rankingTopCell.rankLabel.text = "1위. " + String(gradeCnt) + "개"
            rankingTopCell.ratingLabel.text = gradeString
            rankingTopCell.ratingLabel.textColor = gradeColor
            
            return rankingTopCell
        } else {
            let gradeCnt = users[indexPath.row + 1].stampCount!
            
            rank(gradeCnt: gradeCnt)
            
            let reference = storageRef.child(users[indexPath.row + 1].profileImg) //
            rankingCell.imgView.sd_setImage(with: reference)
            rankingCell.nameLabel.text = users[indexPath.row + 1].name
            rankingCell.rankLabel.text = String(indexPath.row + 2) + "위. " + String(gradeCnt) + "개"
            rankingCell.ratingLabel.text = gradeString
            rankingCell.ratingLabel.textColor = gradeColor
            return rankingCell
        }
        
    }
    
    func radiusSet(imgView: UIImageView) {
        imgView.layer.cornerRadius = 10
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
