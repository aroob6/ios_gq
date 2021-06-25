//
//  HomeViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/17.
//

import UIKit
import UICircularProgressRing
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet var useView: UIView!
    @IBOutlet var couponView: UIView!
    @IBOutlet var circleProgress: UICircularProgressRing!
    @IBOutlet var outView: UIView!
    @IBOutlet var stampCountLabel: UILabel!
    @IBOutlet var couponCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true

        borderSet(view: useView)
        borderSet(view: couponView)
        borderSet(view: outView)
        shadowSet(view: outView)
        
        getDB(uid: Auth.auth().currentUser!.uid)
    }
    
    func borderSet(view: UIView) {
        if view == outView {
            view.layer.cornerRadius = view.frame.height / 2
        } else {
            view.layer.cornerRadius = 10
        }
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 206/255, green: 208/255, blue: 214/255, alpha: 1).cgColor
    }

    func shadowSet(view: UIView) {
        view.layer.shadowRadius = 5 //그림자크기
        view.layer.shadowColor = UIColor.black.cgColor //그림자색
        view.layer.shadowOffset = CGSize(width: 5, height: 5) //그림자의 시작위치
        view.layer.shadowOpacity = 0.5 //그림자의 불투명도
    }
    
    func getDB(uid: String) {
        let db = Firestore.firestore()
        db.collection("User").document(uid).getDocument() { (querySnapshot, err) in
            
            let stampCount = querySnapshot?.get("StampCount") as! Int
            self.circleProgress.value = CGFloat(stampCount)
            self.stampCountLabel.text = String(stampCount) + "개"
            
            let couponCount = querySnapshot?.get("CouponList") as! [String]
            self.couponCountLabel.text = String(couponCount.count)
            
        }
    }
}
