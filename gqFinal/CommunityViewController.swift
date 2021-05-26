//
//  CommunityViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit
import XLPagerTabStrip

class CommunityViewController: ButtonBarPagerTabStripViewController {
    
   

    override func viewDidLoad() {
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.0)!

        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        settings.style.selectedBarHeight = 1.0
        settings.style.selectedBarBackgroundColor = .red
        
        changeCurrentIndexProgressive = { (oldCell : ButtonBarViewCell?, newCell : ButtonBarViewCell?, progressPercentage : CGFloat, changeCurrentIndex : Bool, animated : Bool)-> Void in
            guard changeCurrentIndex == true else {return}
            oldCell?.label.textColor = UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
            newCell?.label.textColor = UIColor.red
            
        }
    
        super.viewDidLoad()
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        
        if currentIndex == 1 {
            NotificationCenter.default.post(name: NSNotification.Name("show"), object: nil) 
        } else if currentIndex == 0 {
            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: nil)
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let news = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommunityNewsViewController")
    
        let home = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommunityHomeViewController")
        
        return [news, home]
       }
}
