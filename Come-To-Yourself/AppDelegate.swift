//
//  AppDelegate.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 8.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
       
        
        
//        RememberUser()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
    }
    
    //KULLANICI HATIRLAMA BÖLÜMÜ
    func RememberUser()
    {
        let user_id : String? = UserDefaults.standard.string(forKey: "kullanici_id")
        
        print(user_id)
        
        if user_id != nil{
            
        }
        
        let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = board.instantiateViewController(withIdentifier: "tabBarS") as! UITabBarController
        window?.rootViewController = tabBar
        
        
    }

}

