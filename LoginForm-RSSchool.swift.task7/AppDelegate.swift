//
//  AppDelegate.swift
//  LoginForm-RSSchool.swift.task7
//
//  Created by Mikita  on 01/09/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //create root VC
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.green

        let screenVC = LoginScreenViewController()
        
        window?.rootViewController = screenVC
        window?.makeKeyAndVisible()
        
        return true
    }

    
    
}

