//
//  RootNavigationController.swift
//  bookin
//
//  Created by Lukasz on 10/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {

	func customTopView(with text: String) -> UIView {
		let label = UILabel(frame: CGRect.zero)
		label.text = text
		label.font = UIFont(name: "Lato-Medium", size: 18)
		label.textColor = Theme.default.black
		label.sizeToFit()
		return label
	}

}
