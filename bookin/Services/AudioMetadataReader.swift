//
//  AudioMetadataReader.swift
//  bookin
//
//  Created by Lukasz on 15/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit
import AVFoundation

struct AudioMetadate {
	let title: String
	let author: String?
}

struct AudioMetadataReader {
	let pathToAudio: URL

	func readMetadate() -> AudioMetadate? {
		let mp3Player = AVPlayerItem(url: pathToAudio)
		let metadatas = mp3Player.asset.commonMetadata
		var title = ""
		var author = ""
		for item in metadatas {
			if item.commonKey == "albumName" {
				guard let t = item.stringValue else { break }
				title = t
			}
			if item.commonKey == "artist" {
				guard let a = item.stringValue else { break }
				author = a
			}
		}
		return AudioMetadate(title: title, author: author)
	}
}
