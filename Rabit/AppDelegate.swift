//
//  AppDelegate.swift
//  Rabit
//
//  Created by hy on 2019. 3. 14..
//  Copyright © 2019년 hy. All rights reserved.
//

import UIKit
import KakaoOpenSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainVC = MainViewController(nibName: MainViewController.className(), bundle: nil)
        mainVC.title = "main1"
        let mainNav = UINavigationController.init()
        mainNav.pushViewController(mainVC, animated: true)
        
        let statVC = StatisticViewController(nibName: nil, bundle: nil)
        statVC.title = "Statistic"
        let statNav = UINavigationController.init()
        statNav.navigationBar.prefersLargeTitles = true
        statNav.pushViewController(statVC, animated: true)
        
        let historyVC = HistoryViewController(nibName: nil, bundle: nil)
        historyVC.title = "History"
        let historyNav = UINavigationController.init()
        historyNav.navigationBar.prefersLargeTitles = true
        historyNav.pushViewController(historyVC, animated: true)
        
        let tabbarController = UITabBarController(nibName: nil, bundle: nil)
        tabbarController.addChildViewController(mainNav)
        tabbarController.addChildViewController(statNav)
        tabbarController.addChildViewController(historyNav)
        tabbarController.selectedIndex = 0
        
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        
        KOSession.shared()?.clientSecret = Constants.kakaoSecretKey
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        KOSession.handleDidEnterBackground()   
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        KOSession.handleDidBecomeActive()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        } else {
            return false
        }
    }
}

