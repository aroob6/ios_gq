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
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: 170, y: 200, width: 50, height: 50) // 위치 크기 조절
        indicator.color = UIColor.green
        
        indicator.hidesWhenStopped = true // indicator stop일때 화면 숨김
        indicator.style = UIActivityIndicatorView.Style.medium
        
        indicator.stopAnimating()
        return indicator
    }()
    
    private var service: PostUserService?
    var users = [postUser]()
    
    func loadData() {
        service = PostUserService()
        service?.get(collectionID: "Sor_Post") { users in
            
            self.users = users
            var cnt: Int = 0
            
            for i in 0 ..< users.count {
                self.db.collection("User").document(users[i].uid).getDocument() { (querySnapshot, err) in

                    self.users[i].name?.append(querySnapshot?.get("Name") as! String)
                    self.users[i].profileImg?.append(querySnapshot?.get("Profile_img") as! String)
                    
                    cnt += 1
                    
                    if cnt == users.count {
                        self.tableView.reloadData()
                        self.indicator.stopAnimating()
                        
                    }
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.indicator) //indicator 등록
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let postCell = UINib(nibName: "CommunityHomeTableViewCell", bundle: nil)
        tableView.register(postCell, forCellReuseIdentifier: "CommunityHomeTableViewCell")
                
        loadData()
        indicator.startAnimating()
        
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
        print("Function: \(#function), line: \(#line)")
        postCell.selectionStyle = .none
        
        //시간 계산
        let diffTime = (Int(NSDate().timeIntervalSince1970 * 1000) - users[indexPath.row].postTime!) / 1000
        let time = Date(timeInterval: -Double(diffTime), since: Date())
        
        postCell.time.text = time.relativeTime
        
        postCell.content.text = users[indexPath.row].letter!
        postCell.picImg.sd_setImage(with: storageRef.child(users[indexPath.row].img![0]))
        postCell.picImg.sd_imageTransition = .fade //fade-in 효과
        
        postCell.name.text = users[indexPath.row].name
        postCell.profileImg.sd_setImage(with: storageRef.child(users[indexPath.row].profileImg))
        postCell.profileImg.sd_imageTransition = .fade //fade-in 효과
        
//        db.collection("User").document(users[indexPath.row].uid).getDocument() { (querySnapshot, err) in
//
//            postCell.name.text = (querySnapshot?.get("Name") as! String)
//            postCell.profileImg.sd_imageTransition = .fade //fade-in 효과
//            postCell.profileImg.sd_setImage(with: storageRef.child(querySnapshot?.get("Profile_img") as! String))
//
//            print("####indexPath.row: \(indexPath.row)")
//        }
        
        print("\(indexPath.row), names: \(users[indexPath.row].name)")
        
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
