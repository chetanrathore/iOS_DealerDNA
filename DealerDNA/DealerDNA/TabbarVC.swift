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
        
        var viewController1 = DashboardVC()
        var viewController2 = DashboardVC()
        var viewController3 = DashboardVC()
        var viewController4 = DashboardVC()
        var viewController5 = DashboardVC()
        
        viewController1 = DashboardVC(nibName: "DashboardVC", bundle: nil)
        viewController2 = DashboardVC(nibName: "DashboardVC", bundle: nil)
        viewController3 = DashboardVC(nibName: "DashboardVC", bundle: nil)
        viewController4 = DashboardVC(nibName: "DashboardVC", bundle: nil)
        viewController5 = DashboardVC(nibName: "DashboardVC", bundle: nil)
        
        navigationVC1 = UINavigationController(rootViewController: viewController1)
        navigationVC2 = UINavigationController(rootViewController: viewController2)
        navigationVC3 = UINavigationController(rootViewController: viewController3)
        navigationVC4 = UINavigationController(rootViewController: viewController4)
        navigationVC5 = UINavigationController(rootViewController: viewController5)
        
        viewController1.tabBarItem = UITabBarItem(
            title: "Dashboard",
            image: #imageLiteral(resourceName: "tabdashboard"),
            tag: 0)
        viewController2.tabBarItem = UITabBarItem(
            title: "Reports",
            image: #imageLiteral(resourceName: "tabpie"),
            tag: 1)
        
        viewController3.tabBarItem = UITabBarItem(
            title: "Tasks",
            image: #imageLiteral(resourceName: "tabcalendercheck"),
            tag: 2)
        
        viewController4.tabBarItem = UITabBarItem(
            title: "Appts",
            image: #imageLiteral(resourceName: "tabcalender"),
            tag: 3)
        
        viewController5.tabBarItem = UITabBarItem(
            title: "Search",
            image: #imageLiteral(resourceName: "tabsearch"),
            tag: 4)
        
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor.black
        
        UITabBar.appearance().tintColor = UIColor.white
        
        UITabBar.appearance().barTintColor = UIColor.black
        
        self.tabBar.isTranslucent = false
        
        self.viewControllers = [navigationVC1,navigationVC2, navigationVC3, navigationVC4, navigationVC5]
        self.selectedIndex = 0
        
        appDelegate.setBadgeValue(viewWithTabbar: self)
        
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
