//
//  AppDelegate.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 25/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        FirebaseApp.configure()
        window?.makeKeyAndVisible()
        window?.rootViewController = RegistrationController()
        return true
    }

}

