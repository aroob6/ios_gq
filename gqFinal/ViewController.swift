//
//  ViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/17.
//

import UIKit
import paper_onboarding

class ViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    @IBOutlet var frame: UIView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    let onBoarding = PaperOnboarding()
    
    fileprivate let items = [
        OnboardingItemInfo(
            informationImage: UIImage(imageLiteralResourceName: "ill"),
                                     title: "일회용품을 줄여서\n 지구를 지켜주세요",
                                     description: "",
                                     pageIcon: UIImage(imageLiteralResourceName: "ill"),
                                     color: UIColor.white,
                                titleColor: UIColor.black,
                          descriptionColor: UIColor.white,
                          titleFont: UIFont(name: "AppleSDGothicNeo-Bold", size: 24.0)!,
                           descriptionFont: UIFont.systemFont(ofSize: 15)),

        OnboardingItemInfo(
            informationImage: UIImage(imageLiteralResourceName: "ill2"),
                                      title: "적립한 스탬프로\n 원하는 상품을 획득하세요",
                                description: "",
                                pageIcon: UIImage(imageLiteralResourceName: "ill2"),
                                      color: UIColor.white,
                                 titleColor: UIColor.black,
                           descriptionColor: UIColor.white,
                                  titleFont: UIFont(name: "AppleSDGothicNeo-Bold", size: 24.0)!,
                            descriptionFont: UIFont.systemFont(ofSize: 15))
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        nextButton.setTitle("Next", for: .normal)
        skipButton.setTitle("Skip", for: .normal)
        
        onBoarding.dataSource = self
        onBoarding.delegate = self
        frame.translatesAutoresizingMaskIntoConstraints = false
        
        frame.addSubview(onBoarding)
    
         // add constraints
         for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
             let constraint = NSLayoutConstraint(item: onBoarding,
                                                 attribute: attribute,
                                                 relatedBy: .equal,
                                                 toItem: frame,
                                                 attribute: attribute,
                                                 multiplier: 1,
                                                 constant: 0)
            frame.addConstraint(constraint)
           }
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 0 {
            nextButton.setTitle("Next", for: .normal)
            skipButton.setTitle("Skip", for: .normal)
        } else if index == 1 {
            nextButton.setTitle("시작하기", for: .normal)
            skipButton.setTitle("Back", for: .normal)
        }
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
   }
    
    func onboardingItemsCount() -> Int {
      return 2
    }
    
    @IBAction func nextClick(_ sender: Any) {
    
        if nextButton.titleLabel?.text == "시작하기" {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
            UIApplication.shared.windows.first?.rootViewController = viewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        } else if nextButton.titleLabel?.text == "Next" {
            onBoarding.currentIndex(onBoarding.currentIndex + 1, animated: true)
        }
    }
    
    @IBAction func skipClick(_ sender: Any) {
        
        if skipButton.titleLabel?.text == "Skip" {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
            UIApplication.shared.windows.first?.rootViewController = viewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        } else if skipButton.titleLabel?.text == "Back" {
            onBoarding.currentIndex(onBoarding.currentIndex - 1, animated: true)
        }
    }
    
}
