//
//  Chapter.swift
//  bookin
//
//  Created by Lukasz on 09/04/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import Foundation
import RealmSwift

final class Chapter: Object {
	dynamic var path: String = ""

	var url: URL? {
		return LibraryFileManager().filePath(with: path)
	}
}
