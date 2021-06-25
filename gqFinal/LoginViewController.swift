//
//  ViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/17.
//

import UIKit
import Firebase
import BEMCheckBox
import FBSDKLoginKit //facebook
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate, UITextFieldDelegate {
   
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var googleButton: UIButton!
    @IBOutlet var appleButton: UIButton!
    @IBOutlet var checkBox: BEMCheckBox!
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passText: UITextField!
    
    let db = Firestore.firestore().collection("User")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowSet(button: loginButton)
        shadowSet(button: facebookButton)
        shadowSet(button: googleButton)
        shadowSet(button: appleButton)
        
        emailText.text = "bora@nate.com"
        passText.text = "123123"
        emailText.delegate = self
        passText.delegate = self
        
        checkBox.on = true
        checkBox.onAnimationType = BEMAnimationType.bounce
        checkBox.offAnimationType = BEMAnimationType.bounce

        //google
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    //화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //리턴 키 터치 시 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //텍스트필드 비활성화
        return true
    }
    
    func shadowSet(button: UIButton) {
        
        if button == facebookButton || button == googleButton || button == appleButton {
            button.layer.cornerRadius = 28
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(red: 206/255, green: 208/255, blue: 214/255, alpha: 0.3).cgColor
        } else {
            button.layer.shadowRadius = 10 //그림자크기
            button.layer.shadowColor = UIColor.black.cgColor //그림자색
            button.layer.shadowOffset = CGSize(width: 5, height: 5) //그림자의 시작위치
            button.layer.shadowOpacity = 0.5 //그림자의 불투명도
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
    
    @IBAction func loginBtnClick(_ sender: Any) {
        if emailText.text!.isEmpty { alertShow(message: "아이디를 입력해 주세요") }
        if passText.text!.isEmpty { alertShow(message: "비밀번호를 입력해 주세요") }
        
        Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!) { (user, error) in
            if user != nil {
                print("login success")
                self.mainPage()
            } else {
                self.alertShow(message: "일치하는 회원정보가 없습니다")
            }
        }
    }
    
    @IBAction func googleLoginBtn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if user != nil {
                self.db.document(String(Auth.auth().currentUser!.uid)).setData([
                    "Name": String(GIDSignIn.sharedInstance()!.currentUser.profile.name!),
                    "Uid": String(Auth.auth().currentUser!.uid),
                    "StampCount": 0,
                    "CouponList": [],
                    "PostCount": 0,
                    "Profile_img": "user_profile/Profile.png"
                ])

                self.mainPage()
            }
        }
    }
    
    @IBAction func facebookLoginBtn(_ sender: Any) {
        facebookLogin()
    }
    
    func facebookLogin() {
        let fbLoginManager: LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            if error != nil {
                NSLog("Process error")
            } else if result?.isCancelled == true {
                NSLog("Cancelled")
            } else {
                NSLog("Logged in")
                self.getFBUserData()
            }
            
        }
    }
    
    func getFBUserData() {
        if let token = AccessToken.current, !token.isExpired {
        // User is logged in, do work such as go to next view controller.
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
            Auth.auth().signIn(with: credential, completion: {(user, error) in
                if user != nil {
                    self.db.document(String(Auth.auth().currentUser!.uid)).setData([
                        "Name": String(Profile.current!.name!),
                        "Uid": String(Auth.auth().currentUser!.uid),
                        "StampCount": 0,
                        "CouponList": [],
                        "PostCount": 0,
                        "Profile_img": "user_profile/Profile.png"
                    ])
                    
                    self.mainPage()
                }
               
            })
        }
    }
    
    func mainPage() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController//storyboaedID
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func alertShow(message: String) {
        
        let alert = UIAlertController(title: "로그인 실패", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}
