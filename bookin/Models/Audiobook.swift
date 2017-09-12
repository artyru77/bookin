//
//  AudiobookE.swift
//  bookin
//
//  Created by Lukasz on 25/03/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

final class Audiobook: Object {
	dynamic var title: String = ""
	dynamic var author: String?
	dynamic var folderName: String = ""
	dynamic var imageName: String?
	dynamic var lastChapterTime: Double = 0.0
	dynamic var lastChapterIndex: Int = 0
	dynamic var addedAt = Date()
	let chapters = List<Chapter>()

	var image: UIImage {
		if let imageName = imageName, let audiobookFolderURL = url,
			let image = UIImage(url: audiobookFolderURL.appendingPathComponent(imageName)) {
			return image
		} else {
			return UIImage(named: "default-audiobook-img")!
		}
	}

	var url: URL? {
		return LibraryFileManager().filePath(with: folderName)
	}
}

extension Audiobook {

	static func findBy(title: String) -> Audiobook? {
		let realm = try! Realm()
		return realm.objects(Audiobook.self).filter("title == %@", title).first
	}

	static func all() -> Results<Audiobook> {
		let realm = try! Realm()
		return realm.objects(Audiobook.self)
	}

	static func add(_ audiobook: Audiobook) {
		let realm = try! Realm()
		try! realm.write {
			realm.add(audiobook)
		}
	}

}
