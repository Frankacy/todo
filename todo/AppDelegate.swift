//
//  AppDelegate.swift
//  todo
//
//  Created by Francois Courville on 2017-12-25.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.rootViewController = ListCoordinatorController()
        window?.makeKeyAndVisible()

        return true
    }
}

