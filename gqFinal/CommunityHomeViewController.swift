//
//  CommunityVoluntViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit
import XLPagerTabStrip
import Firebase

class CommunityHomeViewController: UIViewController, IndicatorInfoProvider, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    private var service: PostUserService?
       private var allusers = [postUser]() {
           didSet {
               DispatchQueue.main.async {
                   self.users = self.allusers
               }
           }
       }
       
       var users = [postUser]() {
           didSet {
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           }
       }
    
    func loadData() {
           service = PostUserService()
           service?.get(collectionID: "Sor_Post") { users in
               self.allusers = users
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let postCell = UINib(nibName: "CommunityHomeTableViewCell", bundle: nil)
        tableView.register(postCell, forCellReuseIdentifier: "CommunityHomeTableViewCell")
        
        loadData()
        
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "가정캠패인")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let postCell = tableView.dequeueReusableCell(withIdentifier: "CommunityHomeTableViewCell") as! CommunityHomeTableViewCell
        
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        
        //시간 계산
        let diffTime = (Int(NSDate().timeIntervalSince1970 * 1000) - users[indexPath.row].postTime!) / 1000
        let time = Date(timeInterval: -Double(diffTime), since: Date())
        
        postCell.time.text = time.relativeTime
        postCell.picImg.sd_setImage(with: storageRef.child(users[indexPath.row].img![0]))
        postCell.content.text = users[indexPath.row].letter!
        
        
        db.collection("User").document(users[indexPath.row].uid).getDocument() { (querySnapshot, err) in
            
            postCell.name.text = (querySnapshot?.get("Name") as! String)
            postCell.profileImg.sd_setImage(with: storageRef.child(querySnapshot?.get("Profile_img") as! String))
        }
        
        return postCell
    }
    
}

extension Date {
    var relativeTime: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_KR") //한국어 변경
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
