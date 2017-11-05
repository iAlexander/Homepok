//
//  AppDelegate.swift
//  HOMEPOK - Catalog of Ukrainian vehicle plates
//
//  Created by Alexander Iashchuk on 12/12/15.
//  Copyright © 2015-2017 Alexander Iashchuk (iAlexander), http://iashchuk.com
//
//  This application is released under the MIT license. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
	}

	func applicationWillTerminate(_ application: UIApplication) {
	}
    
}
