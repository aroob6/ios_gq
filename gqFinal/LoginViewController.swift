//
//  ViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/17.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var googleButton: UIButton!
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowSet(button: loginButton)
        shadowSet(button: facebookButton)
        shadowSet(button: googleButton)
        
        emailText.text = "bora@nate.com"
        passText.text = "123123"
       
    }
    
    func shadowSet(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
        
        button.layer.shadowRadius = 10 //그림자크기
        button.layer.shadowColor = UIColor.black.cgColor //그림자색
        button.layer.shadowOffset = CGSize(width: 5, height: 5) //그림자의 시작위치
        button.layer.shadowOpacity = 0.5 //그림자의 불투명도
        
        if button == facebookButton || button == googleButton {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(red: 206/255, green: 208/255, blue: 214/255, alpha: 0.3).cgColor
        }
    }
    
    @IBAction func loginBtnClick(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!){ (user, error) in
            if user != nil{
                print("login success")
                let storyBoard = UIStoryboard(name: "Main", bundle: nil) //  ‘name’ 에는 스토리보드의 기본이름인 ‘Main’ 을 입력하면 현재 인터페이스 빌더의 스토리보드 객체가 생성
                let viewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController//storyboaedID
                UIApplication.shared.windows.first?.rootViewController = viewController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else {
                print("login fail")
            }
        }
        
        
        
    }
    

}

