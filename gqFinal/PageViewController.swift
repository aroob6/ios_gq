//
//  PageViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/17.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let viewsList: [UIViewController] = {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let firstVc = storyBoard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondVc = storyBoard.instantiateViewController(withIdentifier: "SecondViewController")
        
        return [firstVc, secondVc]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVc = viewsList.first {
            self.setViewControllers([firstVc], direction: .forward, animated: true, completion: nil)
        }

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard  let index = viewsList.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = index - 1
        if previousIndex < 0 { return nil }
        
        return viewsList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewsList.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = index + 1
        if nextIndex == viewsList.count { return nil }
        return viewsList[nextIndex]
    }

}
