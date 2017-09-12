//
//  PlayerCoordinator.swift
//  bookin
//
//  Created by Lukasz on 16/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit

protocol PlayerCoordinatorDelegate: class {
	func dissmis(coordinator: PlayerCoordinator)
}

class PlayerCoordinator: Coordinator {
	var rootNavigationController: UINavigationController
	var childCoordinator: Coordinator?

	weak var navigationDelegate: PlayerCoordinatorDelegate?

	init(rootNavigationController: UINavigationController) {
		self.rootNavigationController = rootNavigationController
	}

	func start(with object: Any?) {
		guard let audiobook = object as? Audiobook else { return }
		let playerViewModel = PlayerViewModel(audiobook: audiobook)
		let playerVC = PlayerViewController(playerViewModel: playerViewModel)
		playerVC.navigateDelegate = self
		rootNavigationController.present(playerVC, animated: true, completion: nil)
	}
}

extension PlayerCoordinator: PlayerViewControllerNavigationDelegate {
	func dissmiss(controller: UIViewController) {
		navigationDelegate?.dissmis(coordinator: self)
	}
}
