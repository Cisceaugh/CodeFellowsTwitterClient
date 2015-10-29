//
//  AppDelegate.swift
//  TwitterCF
//
//  Created by Francisco Ragland Jr on 10/26/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.setupAppearance()
        return true
    }
    
    func setupAppearance() {
        UITabBar.appearance().tintColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
    }
}


