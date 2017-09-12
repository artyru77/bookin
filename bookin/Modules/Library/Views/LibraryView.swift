//
//  LibraryView.swift
//  bookin
//
//  Created by Lukasz on 25/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit
import SnapKit

class LibraryView: UIView {

	let tableView = LibraryTableView()

	init() {
		super.init(frame: CGRect.zero)
		backgroundColor = Theme.default.bookinWhite
		setupTableView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupTableView() {
		tableView.backgroundColor = UIColor.clear
		addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.top.equalTo(self)
			make.bottom.equalTo(self)
			make.left.equalTo(self)
			make.right.equalTo(self)
		}
	}
}
