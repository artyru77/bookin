//
//  UIView+Screenshot.swift
//  bookin
//
//  Created by Lukasz on 16/03/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit

extension UIView {

	func addShadow() {
		layer.masksToBounds = false
		layer.shadowColor = Theme.default.black.cgColor
		layer.shadowOpacity = 0.8
		layer.shadowOffset = CGSize(width: 0, height: 1)
		layer.shadowRadius = 3.0
	}
}
