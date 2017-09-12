//
//  Coordinator.swift
//  bookin
//
//  Created by Lukasz on 10/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit

protocol Coordinator {

	var rootNavigationController: UINavigationController { get set }
	var childCoordinator: Coordinator? { get set }

	func start(with object: Any?)
}
