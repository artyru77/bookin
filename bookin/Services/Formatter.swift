//
//  Formatter.swift
//  bookin
//
//  Created by Lukasz on 04/03/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import Foundation

class Formatter {

	class var duartion: DateComponentsFormatter {
		let formatter = DateComponentsFormatter()
		formatter.unitsStyle = .positional
		formatter.zeroFormattingBehavior = .pad
		formatter.allowedUnits = [.hour, .minute, .second]
		return formatter
	}
}
