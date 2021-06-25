//
//  CommunityMainViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/20.
//

import UIKit

class CommunityMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //largeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 34)!]
        
        NotificationCenter.default.addObserver(self, selector: #selector(showItem), name: Notification.Name("show"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideItem), name: Notification.Name("hide"), object: nil)
        
    }
    
    @objc public func showItem(_ notification: NSNotification) {
        let plus = UIImage(named: "message")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: plus, style: .plain, target: self, action: #selector(self.tap))
        self.navigationItem.rightBarButtonItem!.tintColor = .black
    }
    
    @objc public func hideItem(_ notification: NSNotification) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
    }

    @objc func tap() {
        let alert = UIAlertController(title: "실패", message: "캠페인 등록은 준비되어 있지 않습니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}
