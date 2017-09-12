//
//  PlayerViewController.swift
//  bookin
//
//  Created by Lukasz on 16/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

protocol PlayerViewControllerNavigationDelegate: class {
	func dissmiss(controller: UIViewController)
}

class PlayerViewController: UIViewController {

	private var bookImage = UIImageView()
	private var closeIcon = UIImageView()
	private var titleView = UILabel()
	private var authorView = UILabel()
	private var chapters = UILabel()
	private var playButton = UIImageView()
	private var rewindLeft = UIImageView()
	private var rewindRight = UIImageView()
	private var currentTimeView = UILabel()
	private var totalTimeView = UILabel()
	private var progressView = UIProgressView()

	private let disposeBag = DisposeBag()
	private let playerViewModel: PlayerViewModel

	weak var navigateDelegate: PlayerViewControllerNavigationDelegate?

	init(playerViewModel: PlayerViewModel) {
		self.playerViewModel = playerViewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = PlayerView()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		let v = view as! PlayerView
		bookImage = v.bookImageView
		closeIcon = v.closeView
		titleView = v.titleView
		authorView = v.authorView
		chapters = v.chapters
		playButton = v.playButton
		rewindLeft = v.rewindLeft
		rewindRight = v.rewindRight
		currentTimeView = v.currentTimeView
		totalTimeView = v.totalTimeView
		progressView = v.progressView
		rx_setupBookImage()
		rx_setupClose()
		rx_setupTitle()
		rx_setupAuthor()
		rx_setupChapters()
		rx_setupPlayButton()
		rx_setupRewindLeft()
		rx_setupRewindRight()
		rx_setupCurrentTimeView()
		rx_setupTotalTime()
		rx_setupProgressView()
    }

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		playerViewModel.stopPlaying()
	}

	private func rx_setupBookImage() {
		playerViewModel.audiobook
			.map { $0.image }
			.bindTo(bookImage.rx.image)
			.addDisposableTo(disposeBag)
	}

	private func rx_setupTitle() {
		playerViewModel
			.audiobook.asObservable()
			.map { $0.title }
			.bindTo(titleView.rx.text)
			.addDisposableTo(disposeBag)
	}

	private func rx_setupAuthor() {
		playerViewModel
			.audiobook.asObservable()
			.map { $0.author }
			.bindTo(authorView.rx.text)
			.addDisposableTo(disposeBag)
	}

	private func rx_setupChapters() {
		playerViewModel.currentChapterObservable()
			.bindTo(chapters.rx.text)
			.addDisposableTo(disposeBag)
	}

	private func rx_setupClose() {
		closeIcon.rx.gesture(.tap)
			.subscribe(onNext: { _ in
				self.dismiss(animated: true, completion: { 
					self.navigateDelegate?.dissmiss(controller: self)
				})
			}).addDisposableTo(disposeBag)
	}

	private func rx_setupPlayButton() {
		playerViewModel.playerStatusObservable()
			.subscribe(onNext: { state in
				if state {
					self.playButton.image = #imageLiteral(resourceName: "pause")
				} else {
					self.playButton.image = #imageLiteral(resourceName: "play")
				}
			}).addDisposableTo(disposeBag)

		playButton.rx.gesture(.tap)
			.subscribe(onNext: { _ in self.playerViewModel.togglePlay() })
			.addDisposableTo(disposeBag)
	}

	private func rx_setupRewindLeft() {
		rewindLeft.rx.gesture(.tap)
			.subscribe(onNext: { _ in self.playerViewModel.rewindBack() })
			.addDisposableTo(disposeBag)
	}

	private func rx_setupRewindRight() {
		rewindRight.rx.gesture(.tap)
			.subscribe(onNext: { _ in self.playerViewModel.rewindForward() })
			.addDisposableTo(disposeBag)
	}

	private func rx_setupCurrentTimeView() {
		playerViewModel.currentChapterTimeObservable()
			.map{ Formatter.duartion.string(from: $0) }
			.bindTo(currentTimeView.rx.text)
			.addDisposableTo(disposeBag)
	}

	private func rx_setupTotalTime() {
		playerViewModel.currentChapterDurationObservable()
			.map { Formatter.duartion.string(from: $0) }
			.bindTo(totalTimeView.rx.text)
			.addDisposableTo(disposeBag)
	}

	private func rx_setupProgressView() {
		playerViewModel.chapterProgressObservable()
			.subscribe(onNext: { self.progressView.setProgress(Float($0), animated: true) })
			.addDisposableTo(disposeBag)
	}
}
