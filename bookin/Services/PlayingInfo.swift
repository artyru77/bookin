//
//  PlayingInfoCenterService.swift
//  bookin
//
//  Created by Lukasz on 22/03/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import Foundation
import MediaPlayer
import AVFoundation

class PlayingInfo {
	private let audiobook: Audiobook
	private let mediaPlayerCmd: MPRemoteCommandCenter
	private let mediaPlayerInfo: MPNowPlayingInfoCenter
	private let audioSession: AVAudioSession

	init(audiobook: Audiobook,
	     mediaPlayerCmd: MPRemoteCommandCenter = MPRemoteCommandCenter.shared(),
	     mediaPlayerInfo: MPNowPlayingInfoCenter = MPNowPlayingInfoCenter.default(),
	     audioSession: AVAudioSession = AVAudioSession.sharedInstance()) {
		self.audiobook = audiobook
		self.mediaPlayerCmd = mediaPlayerCmd
		self.mediaPlayerInfo = mediaPlayerInfo
		self.audioSession = audioSession
	}

	func start() {
		try! audioSession.setCategory(AVAudioSessionCategoryPlayback)
		try! audioSession.setActive(true)
		UIApplication.shared.beginReceivingRemoteControlEvents()
	}

	func stop() {
		try! audioSession.setActive(false)
		UIApplication.shared.endReceivingRemoteControlEvents()
	}

	func setupBasicInfoCenter(with duration: Double) {
		let img = audiobook.image
		mediaPlayerInfo.nowPlayingInfo = [
			MPMediaItemPropertyAlbumTitle: audiobook.title,
			MPMediaItemPropertyArtist: audiobook.author ?? "",
			MPMediaItemPropertyArtwork: MPMediaItemArtwork(boundsSize: img.size, requestHandler: { _ in img }),
			MPMediaItemPropertyAlbumTrackCount: audiobook.chapters.count,
			MPMediaItemPropertyPlaybackDuration: duration
		]
	}
}
