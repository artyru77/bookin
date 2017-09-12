//
//  AppCoordinator.swift
//  bookin
//
//  Created by Lukasz on 10/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

	var rootNavigationController: UINavigationController
	var childCoordinator: Coordinator?

	init(rootNavigationController: UINavigationController) {
		self.rootNavigationController = rootNavigationController
	}

	func start(with object: Any? = nil) {
		let libraryCoord = LibraryCoordinator(rootNavigationController: rootNavigationController)
		childCoordinator = libraryCoord
		libraryCoord.start()
	}

}
