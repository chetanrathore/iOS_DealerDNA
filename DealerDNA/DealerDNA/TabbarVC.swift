//
//  TabbarVC.swift
//  DealerDNA
//
//  Created by LaNet on 4/5/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var navigationVC1 = UINavigationController()
        var navigationVC2 = UINavigationController()
        var navigationVC3 = UINavigationController()
        var navigationVC4 = UINavigationController()
        var navigationVC5 = UINavigationController()
        
        var viewController1 = MainDashboardVC()
        var viewController2 = MainDashboardVC()
        var viewController3 = MainDashboardVC()
        var viewController4 = MainDashboardVC()
        var viewController5 = MainDashboardVC()
        
        viewController1 = MainDashboardVC(nibName: "MainDashboardVC", bundle: nil)
        viewController2 = MainDashboardVC(nibName: "MainDashboardVC", bundle: nil)
        viewController3 = MainDashboardVC(nibName: "MainDashboardVC", bundle: nil)
        viewController4 = MainDashboardVC(nibName: "MainDashboardVC", bundle: nil)
        viewController5 = MainDashboardVC(nibName: "MainDashboardVC", bundle: nil)
        
        navigationVC1 = UINavigationController(rootViewController: viewController1)
        navigationVC2 = UINavigationController(rootViewController: viewController2)
        navigationVC3 = UINavigationController(rootViewController: viewController3)
        navigationVC4 = UINavigationController(rootViewController: viewController4)
        navigationVC5 = UINavigationController(rootViewController: viewController5)
        
        viewController1.tabBarItem = UITabBarItem(
            title: "Dashboard",
            image: #imageLiteral(resourceName: "dashboard"),
            tag: 0)
        viewController2.tabBarItem = UITabBarItem(
            title: "Reports",
            image: #imageLiteral(resourceName: "dashboard"),
            tag: 1)
        
        viewController3.tabBarItem = UITabBarItem(
            title: "Tasks",
            image: #imageLiteral(resourceName: "dashboard"),
            tag: 2)
        
        viewController4.tabBarItem = UITabBarItem(
            title: "Appts",
            image: #imageLiteral(resourceName: "dashboard"),
            tag: 3)
        
        viewController5.tabBarItem = UITabBarItem(
            title: "Search",
            image: #imageLiteral(resourceName: "dashboard"),
            tag: 4)
        
        
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor.black
        
        UITabBar.appearance().tintColor = UIColor.white
        
        UITabBar.appearance().barTintColor = UIColor.black
        
        self.tabBar.isTranslucent = false
        
        self.viewControllers = [navigationVC1,navigationVC2, navigationVC3, navigationVC4, navigationVC5]
        self.selectedIndex = 0
        
        self.tabBar.items?[3].badgeValue = "20"
        
        
        self.tabBar.items?[2].badgeValue = "31"
        if #available(iOS 10.0, *) {
            self.tabBar.items?[2].badgeColor = UIColor.green
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            
            
        }else if item.tag == 1{
            
        }else if item.tag == 2{
            
        }else if item.tag == 3{
        }else if item.tag == 4{
            
        }else{
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
