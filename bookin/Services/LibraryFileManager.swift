//
// Created by Lukasz on 11/02/2017.
// Copyright (c) 2017 candy bar code. All rights reserved.
//

import Foundation
import FileKit

struct LibraryFileManager {
    private let userDirectory: Path

    init(userDirectory: Path = Path.userDocuments) {
        self.userDirectory = userDirectory
    }

    func saveNewAudiobooks() {
        userDirectory
			.find(searchDepth: 1) { isDirectory(path: $0) }
			.forEach { path in
				let chapters = getChapters(for: path)
				guard chapters.count > 0 else { return }
				guard let firstChapterURL = filePath(with: chapters[0].path) else { return }
				let metadata = readAudioMetadata(from: firstChapterURL)

				guard Audiobook.findBy(title: metadata.title) == nil else { return }
				let imgName = findAudiobookImageName(in: path)

				let audiobook = Audiobook()
				audiobook.title = metadata.title
				audiobook.author = metadata.author
				audiobook.folderName = path.fileName
				audiobook.imageName = imgName
				audiobook.chapters.append(objectsIn: chapters)
				Audiobook.add(audiobook)
			}
    }

	func filePath(with name: String) -> URL? {
		let filePath = userDirectory + name
		guard filePath.exists else { return nil }
		return filePath.url
	}

    private func getChapters(for audiobookPath: Path) -> [Chapter] {
		let audiobookFolderName = audiobookPath.fileName
        return audiobookPath
                .find(searchDepth: 1) { isAudioFile(fileExt: $0.pathExtension) }
                .map { path -> Chapter in
					return Chapter(value: ["path": audiobookFolderName + "/" + path.fileName])
                }
    }

	private func readAudioMetadata(from url: URL) -> AudioMetadate {
		guard let metadata = AudioMetadataReader(pathToAudio: url).readMetadate() else {
			return AudioMetadate(title: url.lastPathComponent, author: nil)
		}
		return metadata
	}

	private func findAudiobookImageName(in path: Path) -> String? {
		let imagesPaths = path.find(searchDepth: 1, condition: { isImageFile(fileExt: $0.pathExtension) })
			.map { p -> Path in
				return p
			}.sorted { (p1, p2) -> Bool in
				return p1.fileSize! < p2.fileSize!
			}
		guard imagesPaths.count > 0 else { return nil }
		return imagesPaths.last!.fileName
	}

    private func isDirectory(path: Path) -> Bool {
        return path.isDirectory
    }

    private func isAudioFile(fileExt: String) -> Bool {
        return ["mp3"].contains(fileExt)
    }

	private func isImageFile(fileExt: String) -> Bool {
		return ["jpg", "jpeg", "png", "bmp"].contains(fileExt)
	}
}
