//
//  http://kyivapp.com
//  http://iashchuk.com
//
//  AppDelegate.swift
//
//  HOMEPOK - Catalog of Ukrainian vehicle plates
//  File created by Alexander Iashchuk on 12/12/15.
//   App precisely handcrafted in KyivApp Development Studio
//  Application version 1.9.9, build 9
//  Last modification on 2019.03.16
//
//  Copyright © 2015-2017 iashchuk.com
//  Alexander Iashchuk (iAlexander)
//  All rights reserved
//
//  This application is released under the MIT license.
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
