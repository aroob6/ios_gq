//
//  CommunityMainViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/20.
//

import UIKit

class CommunityMainViewController: UIViewController {
    var check: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showItem), name: Notification.Name("show"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideItem), name: Notification.Name("hide"), object: nil)

    }
    
    @objc public func showItem(_ notification: NSNotification) {
        let plus = UIImage(named: "bubble")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: plus)
    }
    
    @objc public func hideItem(_ notification: NSNotification) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem()
    }

}
