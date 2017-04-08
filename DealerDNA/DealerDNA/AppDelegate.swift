//
//  AppDelegate.swift
//  DealerDNA
//
//  Created by LaNet on 3/21/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import CoreData
import PPRevealSideViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var selectedMenu: String?
    var dashBoardTiles = NSMutableArray()
    var sideMenuItem = NSMutableArray()
    var appCityLocation: String!
    var temprature:NSMutableDictionary!
    
    //For Tabbadge value
    var tabDashboard = ""
    var tabReports = ""
    var tabTasks = ""
    var tabSearch = ""
    var tabAppts = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // NotificationCenter.default.addObserver(self, selector: #selector(self.changeDeviceOrientation), name: Notification.Name.UIDeviceOrientationDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeDeviceOrientation), name: Notification.Name(rawValue: "OrientationWillChange"), object: nil)
        
        IQKeyboardManager.sharedManager().enable = true
        window = UIWindow(frame: UIScreen.main.bounds)
        let loginVC = LoginVC(nibName: "LoginVC", bundle: nil)
//        let vc = TabbarVC()
        
        let passcodeVC = PasscodeVC(nibName: "PasscodeVC", bundle: nil)
        let revealSideViewController = PPRevealSideViewController(rootViewController: UINavigationController(rootViewController: loginVC))
        
        revealSideViewController?.directionsToShowBounce = .none
        revealSideViewController?.resetOption(.optionsiOS7StatusBarFading)
        revealSideViewController?.setOption(.optionsNoStatusBar)
        // revealSideViewController?.fakeiOS7StatusBarColor = UIColor.clear
        // revealSideViewController?.panInteractionsWhenClosed = [.navigationBar,.contentView]
        //         let main = MainDashboardVC(nibName: "MainDashboardVC", bundle: nil)
        window?.rootViewController = passcodeVC//revealSideViewController
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DealerDNA")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func changeDeviceOrientation(){
        Screen.screenWidth = UIScreen.main.bounds.width
        Screen.screenHeight = UIScreen.main.bounds.height
    }
    
    func logut(){
        appDelegate.dashBoardTiles.removeAllObjects()
        appDelegate.sideMenuItem.removeAllObjects()
    }
    
    //Set Tabbar BadgeValue
    func setBadgeValue(viewWithTabbar: UIViewController){
        if !appDelegate.tabDashboard.isEmpty{
            viewWithTabbar.tabBarController?.tabBar.items?[0].badgeValue = appDelegate.tabDashboard
        }
        if !appDelegate.tabReports.isEmpty{
            viewWithTabbar.tabBarController?.tabBar.items![1].badgeValue = appDelegate.tabReports
        }
        if !appDelegate.tabTasks.isEmpty{
            viewWithTabbar.tabBarController?.tabBar.items![2].badgeValue = appDelegate.tabTasks
        }
        if !appDelegate.tabAppts.isEmpty{
            viewWithTabbar.tabBarController?.tabBar.items![3].badgeValue = appDelegate.tabAppts
            if #available(iOS 10.0, *) {
                viewWithTabbar.tabBarController?.tabBar.items?[3].badgeColor = AppColor.greenColor
            } else {
                // Fallback on earlier versions
            }
        }
        if !appDelegate.tabSearch.isEmpty{
            viewWithTabbar.tabBarController?.tabBar.items![4].badgeValue = appDelegate.tabSearch
        }
    }
    
}

