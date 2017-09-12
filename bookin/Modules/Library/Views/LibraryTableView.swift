//
//  LibraryTableView.swift
//  bookin
//
//  Created by Lukasz on 21/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit

class LibraryTableView: UITableView {

	override init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: frame, style: style)
		self.separatorStyle = .none
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
