//
//  AudiobookCell.swift
//  bookin
//
//  Created by Lukasz on 10/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit
import SnapKit

class AudiobookCell: UITableViewCell {

	lazy var title = UILabel()
	lazy var author = UILabel()
	lazy var imgView = UIImageView()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupImageView()
		setupTitleLabel()
		setupAuthorLabel()
		selectionStyle = .none
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setClearBackground() {
		backgroundColor = Theme.default.bookinWhite
	}

	func setDarkWhiteBackground() {
		backgroundColor = Theme.default.bookinGrey
	}

	private func setupImageView() {
		imgView.contentMode = .scaleToFill
		addSubview(imgView)
		imgView.addShadow()
		imgView.snp.makeConstraints { make in
			make.left.equalTo(6)
			make.top.equalTo(6)
			make.bottom.equalTo(-6)
			make.width.equalTo(imgView.snp.height)
		}
	}

	private func setupTitleLabel() {
        addSubview(title)
        title.font = UIFont(name: "Lato-Medium", size: 16.0)
		title.textColor = Theme.default.darkBlack
		title.snp.makeConstraints { make in
			make.top.equalTo(8)
			make.left.equalTo(imgView.snp.right).offset(12)
		}
	}

	private func setupAuthorLabel() {
		addSubview(author)
		author.font = UIFont(name: "Lato-Light", size: 10.0)
		author.textColor = Theme.default.black
		author.snp.makeConstraints { make in
			make.top.equalTo(title.snp.bottom).offset(4)
			make.left.equalTo(imgView.snp.right).offset(12)
		}
	}
}
