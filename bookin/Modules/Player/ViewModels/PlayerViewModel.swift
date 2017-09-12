//
//  PlayerViewModel.swift
//  bookin
//
//  Created by Lukasz on 25/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import Foundation
import AVFoundation
import RxSwift
import RxOptional

struct PlayerViewModel {

	let audiobook: Observable<Audiobook>
	let totalChaptersNumberObservable: Observable<Int>
	private let player: Player
	private	let playerInfo: PlayingInfo
	private let disposeBag = DisposeBag()

	init(audiobook: Audiobook) {
		self.audiobook = Observable.just(audiobook)
		self.player = Player(chapters: Array(audiobook.chapters), chapter: audiobook.lastChapterIndex,
		                     chapterTime: audiobook.lastChapterTime)
		self.playerInfo = PlayingInfo(audiobook: audiobook)
		self.totalChaptersNumberObservable = Observable.just(audiobook.chapters.count)

		rx_observeForPlayerInfo()
	}

	func rewindForward() {
		player.rewind(with: 30.0)
	}

	func rewindBack() {
		player.rewind(with: -30.0)
	}

	func currentChapterObservable() -> Observable<String> {
		let currentChapterNumberObservable = player.currentChapter.asObservable()
		return Observable.combineLatest(currentChapterNumberObservable, totalChaptersNumberObservable,
		                                resultSelector: { "\($0+1)/\($1)" })
	}

	func chapterProgressObservable() -> Observable<Double> {
		let chapterDuration = currentChapterDurationObservable()
		let chapterTime = currentChapterTimeObservable()
		return Observable.combineLatest(chapterTime, chapterDuration, resultSelector: { $0/$1 })
	}

	func currentChapterDurationObservable() -> Observable<Double> {
		return player.currentItemDurationObservable()
	}

	func currentChapterTimeObservable() -> Observable<Double> {
		return player.currentItemTimeObservable()
	}

	func playerStatusObservable() -> Observable<Bool> {
		return player.playingStatusObservable()
	}

	func stopPlaying() {
		player.stopPlaying()
	}

	func togglePlay() {
		if player.isPlaying() {
			player.pause()
		} else {
			player.play()
		}
	}

	// Observe player and manage PlayerInfo
	private func rx_observeForPlayerInfo()  {
		let chapterDurationObservable = currentChapterDurationObservable()
		let playerStatus = playerStatusObservable()
		Observable.combineLatest(chapterDurationObservable, playerStatus, resultSelector: { ($0, $1) })
			.subscribe(onNext: { (chapterDuration, isPlaying) in
				if isPlaying {
					self.playerInfo.setupBasicInfoCenter(with: chapterDuration)
					self.playerInfo.start()
				} else {
					sleep(1)
					self.playerInfo.stop()
				}
			}).addDisposableTo(disposeBag)

	}
}
