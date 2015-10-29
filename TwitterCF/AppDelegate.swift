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
        
//        self.setupNavigationController()
        
        return true
    }
    
    func setupNavigationController() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewControllerWithIdentifier(HomeViewController.identifier())
        let navigationController = UINavigationController(rootViewController: homeViewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }

}

