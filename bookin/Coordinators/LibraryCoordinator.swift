//
//  LibraryCoordinator.swift
//  bookin
//
//  Created by Lukasz on 10/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit

class LibraryCoordinator: Coordinator {

	var rootNavigationController: UINavigationController
	var childCoordinator: Coordinator?

	init(rootNavigationController: UINavigationController) {
		self.rootNavigationController = rootNavigationController
	}

	func start(with object: Any? = nil) {
		let libraryVM = LibraryViewModel()
		let libraryVC = LibraryViewController(libraryViewModel: libraryVM)
		libraryVC.navigationDelegate = self
		rootNavigationController.pushViewController(libraryVC, animated: true)
	}
}

extension LibraryCoordinator: LibraryViewControllerNavigationDelegate {

	func clickItem(with audiobook: Audiobook, at: UIViewController) {
		let playerCoord = PlayerCoordinator(rootNavigationController: rootNavigationController)
		playerCoord.navigationDelegate = self
		childCoordinator = playerCoord
		playerCoord.start(with: audiobook)
	}
}

extension LibraryCoordinator: PlayerCoordinatorDelegate {
	func dissmis(coordinator: PlayerCoordinator) {
		childCoordinator = nil
	}
}
