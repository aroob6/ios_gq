//
//  UserViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/20.
//

import UIKit
import Firebase
import FirebaseStorageUI
import BEMCheckBox

class UserViewController: UIViewController {
    
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var oneView: UIView!
    @IBOutlet var twoView: UIView!
    @IBOutlet var threeView: UIView!
    @IBOutlet var fourView: UIView!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var checkBox: BEMCheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.clipsToBounds = true //네비게이션 바 줄 제거
        navigationController?.navigationBar.barTintColor = .white //네비게이션 바 배경색
        
        checkBox.on = true
        checkBox.onAnimationType = BEMAnimationType.bounce
        checkBox.offAnimationType = BEMAnimationType.bounce
        
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        
        viewSet(view: oneView)
        viewSet(view: twoView)
        viewSet(view: threeView)
        viewSet(view: fourView)
        
        oneView.isUserInteractionEnabled = true
        oneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onetap)))
        
        twoView.isUserInteractionEnabled = true
        twoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.twotap)))
        
        threeView.isUserInteractionEnabled = true
        threeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.threetap)))
        
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        db.collection("User").document(Auth.auth().currentUser!.uid).getDocument() { (querySnapshot, err) in
            
            let name = querySnapshot?.get("Name") as! String
            self.nickNameLabel.text = name
            
            let profileImg = querySnapshot?.get("Profile_img") as! String
            let reference = storageRef.child(profileImg)
            self.profileImg.sd_setImage(with: reference)
        }

    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil) //  ‘name’ 에는 스토리보드의 기본이름인 ‘Main’ 을 입력하면 현재 인터페이스 빌더의 스토리보드 객체가 생성
        let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController//storyboaedID
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
    func viewSet(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(red: 206/255, green: 208/255, blue: 214/255, alpha: 0.3).cgColor
        view.layer.borderWidth = 1
    }

    @objc func onetap() { alertShow(message: "개인정보 수정은 준비되어 있지 않습니다.") }
    @objc func twotap() { alertShow(message: "비밀번호 변경은 준비되어 있지 않습니다.") }
    @objc func threetap() { alertShow(message: "환경설정은 준비되어 있지 않습니다.") }

    func alertShow(message: String) {
        
        let alert = UIAlertController(title: "실패", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}
