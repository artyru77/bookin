//
//  AppDelegate.swift
//  bookin
//
//  Created by Lukasz on 10/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var appCoordinator: AppCoordinator!

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// manage main routing
		window = UIWindow(frame: UIScreen.main.bounds)
		let rootViewController = RootNavigationController()
		appCoordinator = AppCoordinator(rootNavigationController: rootViewController)
		appCoordinator.start()
		window?.rootViewController = rootViewController
		window?.makeKeyAndVisible()

		Theme.setGlobalTheme()

		LibraryFileManager().saveNewAudiobooks()

		return true
	}
}

