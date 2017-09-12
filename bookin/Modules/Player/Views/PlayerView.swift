//
//  PlayerView.swift
//  bookin
//
//  Created by Lukasz on 21/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit
import SnapKit

class PlayerView: UIView {

	let bookImageView = UIImageView()
	let closeView = UIImageView(image: #imageLiteral(resourceName: "close"))
	let titleView = UILabel()
	let authorView = UILabel()
	let chapters = UILabel()
	let progressView = UIProgressView(progressViewStyle: .bar)
	let currentTimeView = UILabel()
	let totalTimeView = UILabel()

	let playButton = UIImageView(image: #imageLiteral(resourceName: "play"))
	let pauseButton = UIImageView(image: #imageLiteral(resourceName: "pause"))
	let rewindLeft = UIImageView(image: #imageLiteral(resourceName: "rewind-left"))
	let rewindRight = UIImageView(image: #imageLiteral(resourceName: "rewind-right"))

	init() {
		super.init(frame: CGRect.zero)
		backgroundColor = Theme.default.bookinWhite
		setupBookImageView()
		setupTitleView()
		setupAuthorView()
		setupChaptersView()
		setupProgressView()
		setupCloseView()
		setupCurrentTimeView()
		setupTotalTimeView()
		setupPlayButton()
		setupPauseButton()
		setupRewindLeftButton()
		setupRewindRightButton()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupCloseView() {
		addSubview(closeView)
		closeView.snp.makeConstraints { make in
			make.left.equalTo(20)
			make.top.equalTo(30)
		}
	}

	private func setupBookImageView() {
		addSubview(bookImageView)
		bookImageView.addShadow()
		bookImageView.snp.makeConstraints { make in
			make.top.equalTo(70)
			make.left.equalTo(24)
			make.right.equalTo(-24)
			make.height.equalTo(bookImageView.snp.width)
		}
	}

	private func setupTitleView() {
		titleView.textColor = Theme.default.black
		titleView.textAlignment = .left
		titleView.font = UIFont(name: "Lato-Medium", size: 30.0)
		addSubview(titleView)
		titleView.snp.makeConstraints { make in
			make.top.equalTo(bookImageView.snp.bottom).offset(16)
			make.left.equalTo(24)
			make.right.equalTo(-24)
		}
	}

	private func setupAuthorView() {
		authorView.textColor = Theme.default.black
		authorView.textAlignment = .left
		authorView.font = UIFont(name: "Lato-Light", size: 15.0)
		addSubview(authorView)
		authorView.snp.makeConstraints { make in
			make.top.equalTo(titleView.snp.bottom).offset(8)
			make.left.equalTo(24)
			make.right.equalTo(-24)
		}
	}

	func setupChaptersView() {
		chapters.textColor = Theme.default.black
		chapters.textAlignment = .center
		chapters.font = UIFont(name: "Lato-Light", size: 12.0)
		addSubview(chapters)
		chapters.snp.makeConstraints { make in
			make.centerX.equalTo(self)
			make.top.equalTo(authorView.snp.bottom).offset(8)
		}
	}

	private func setupProgressView() {
		progressView.progress = 0.5
		progressView.progressTintColor = Theme.default.black
		progressView.tintColor = Theme.default.white
		progressView.trackTintColor = Theme.default.white
		addSubview(progressView)
		progressView.snp.makeConstraints { make in
			make.top.equalTo(chapters.snp.bottom).offset(8)
			make.left.equalTo(self).offset(24)
			make.right.equalTo(self).offset(-24)
		}
	}

	private func setupCurrentTimeView() {
		currentTimeView.textColor = Theme.default.black
		currentTimeView.font = UIFont(name: "Lato-Light", size: 12.0)
		addSubview(currentTimeView)
		currentTimeView.snp.makeConstraints { make in
			make.left.equalTo(8)
			make.top.equalTo(progressView.snp.bottom).offset(12)
		}
	}

	private func setupTotalTimeView() {
		totalTimeView.textColor = Theme.default.black
		totalTimeView.font = UIFont(name: "Lato-Light", size: 12.0)
		addSubview(totalTimeView)
		totalTimeView.snp.makeConstraints { make in
			make.right.equalTo(-8)
			make.top.equalTo(progressView.snp.bottom).offset(12)
		}
	}

	private func setupPlayButton() {
		addSubview(playButton)
		playButton.snp.makeConstraints { make in
			make.top.equalTo(progressView.snp.bottom).offset(48)
			make.centerX.equalTo(self)
		}
	}

	private func setupPauseButton() {
		pauseButton.isHidden = true
		addSubview(pauseButton)
		pauseButton.snp.makeConstraints { make in
			make.top.equalTo(progressView.snp.bottom).offset(48)
			make.centerX.equalTo(self)
		}
	}

	private func setupRewindLeftButton() {
		addSubview(rewindLeft)
		rewindLeft.snp.makeConstraints { make in
			make.top.equalTo(progressView.snp.bottom).offset(48)
			make.right.equalTo(playButton.snp.left).offset(-48)
		}
	}

	private func setupRewindRightButton() {
		addSubview(rewindRight)
		rewindRight.snp.makeConstraints { make in
			make.top.equalTo(progressView.snp.bottom).offset(48)
			make.left.equalTo(playButton.snp.right).offset(48)
		}
	}
}
