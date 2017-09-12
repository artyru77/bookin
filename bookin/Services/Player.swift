//
//  Player.swift
//  bookin
//
//  Created by Lukasz on 07/03/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import Foundation
import AVFoundation
import RxSwift
import RxOptional

class Player {

	private let player: AVPlayer
	private let playerItems: [AVPlayerItem]
	var currentChapter: Variable<Int>

	private var timeObserver: Any?
	private let disposeBag = DisposeBag()

	init(chapters: [Chapter], chapter: Int, chapterTime: Double) {
		self.playerItems = chapters.map({ AVPlayerItem(url: $0.url!) })

		let currentPlayerItem = playerItems[chapter]
		self.player = AVPlayer(playerItem: currentPlayerItem)
		self.player.seek(to: CMTime(seconds: chapterTime, preferredTimescale: 1), toleranceBefore: kCMTimeZero,
		                 toleranceAfter: kCMTimeZero)
		self.currentChapter = Variable<Int>(chapter)

		rx_updatePlayerWithNewItem()
		rx_playerItemDidPlayToEnd()
	}

	deinit {
		pause()
		removeTimeObserver()
	}

	func isPlaying() -> Bool {
		return player.rate != 0.0
	}

	func stopPlaying() {
		pause()
		removeTimeObserver()
	}

	func play() {
		player.play()
	}

	func pause() {
		player.pause()
	}

	func rewind(with seconds: Double) {
		guard let currentItem = player.currentItem else { return }
		let newTime = Double(CMTimeGetSeconds(player.currentTime())) + seconds
		if newTime < 0.0 {
			let newChapterIndex = currentChapter.value - 1
			if newChapterIndex >= 0 {
				currentChapter.value = newChapterIndex
			}
		} else if newTime >= Double(CMTimeGetSeconds(currentItem.asset.duration)) {
			let newChapterIndex = currentChapter.value + 1
			if newChapterIndex < playerItems.count {
				currentChapter.value = newChapterIndex
			}
		} else {
			let time = CMTime(seconds: newTime, preferredTimescale: 1)
			player.seek(to: time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
		}
	}

	func playingStatusObservable() -> Observable<Bool> {
		return player.rx.observe(Float.self, "rate")
			.filterNil()
			.map({ $0 != 0.0 })
	}

	func currentItemDurationObservable() -> Observable<Double> {
		return player.rx.observe(AVPlayerItem.self, "currentItem")
			.filterNil()
			.map({ Double(CMTimeGetSeconds($0.asset.duration)) })
	}

	func currentItemTimeObservable() -> Observable<Double> {
		let cmTime = CMTime(seconds: 1.0, preferredTimescale: 1)
		return Observable.create({ [unowned self] o -> Disposable in
			self.timeObserver = self.player.addPeriodicTimeObserver(forInterval: cmTime, queue: nil) { cmTime in
				o.onNext(Double(CMTimeGetSeconds(cmTime)))
			}
			return Disposables.create()
		})
	}

	private func rx_updatePlayerWithNewItem() {
		currentChapter.asObservable()
			.map({ [unowned self] index -> AVPlayerItem in
				self.playerItems[index]
			})
			.subscribe(onNext: { [unowned self] item in
				self.player.replaceCurrentItem(with: item)
				self.play()
			})
			.addDisposableTo(disposeBag)
	}

	private func rx_playerItemDidPlayToEnd() {
		NotificationCenter.default.rx.notification(NSNotification.Name.AVPlayerItemDidPlayToEndTime)
			.map { [unowned self] _ -> Int? in
				let newChapterIndex = self.currentChapter.value + 1
				guard newChapterIndex <= self.playerItems.count else { return nil }
				return newChapterIndex
			}
			.filterNil()
			.bindTo(currentChapter)
			.addDisposableTo(disposeBag)
	}

	private func removeTimeObserver() {
		if timeObserver != nil {
			player.removeTimeObserver(timeObserver!)
		}
	}
}
