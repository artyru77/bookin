//
//  Theme.swift
//  bookin
//
//  Created by Lukasz on 18/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit
import ChameleonFramework

class Theme {
	let bookinWhite = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00)
	let bookinGrey = UIColor(red:0.94, green:0.94, blue:0.95, alpha:1.00)
	let white = FlatWhite()
	let darkWhite = FlatWhiteDark()
	let black = FlatBlack()
	let darkBlack = FlatBlackDark()

	static let `default` = Theme()

	static func setGlobalTheme() {
		Chameleon.setGlobalThemeUsingPrimaryColor(Theme.default.bookinWhite, with: .contrast)
	}
}
