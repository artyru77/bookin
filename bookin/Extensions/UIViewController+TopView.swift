//
//  UIViewController+TopView.swift
//  bookin
//
//  Created by Lukasz on 15/03/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit

extension UIViewController {

	func setCustomTitleView(with text: String) {
		guard let nc = navigationController as? RootNavigationController else { return }
		navigationItem.titleView = nc.customTopView(with: text)
	}

}
