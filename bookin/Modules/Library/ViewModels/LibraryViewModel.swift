//
//  LibraryViewModel.swift
//  bookin
//
//  Created by Lukasz on 11/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxRealm

struct LibraryViewModel {

	func libraryDBObservable() -> Observable<([Audiobook], RealmChangeset?)> {
		let audiobooks = Audiobook.all()
		return Observable.changesetArrayFrom(audiobooks)
	}

//	private var libraryFileManager: LibraryFileManager
//
//    init(libraryFileManager: LibraryFileManager) {
//        self.libraryFileManager = libraryFileManager
//    }
//
//	func getLibrary() -> Observable<[Audiobook]> {
//		let lib = libraryFileManager.getAudiobooks()
//		return Observable.create { o -> Disposable in
//			o.onNext(lib)
//			o.onCompleted()
//			return Disposables.create()
//		}
//	}
}
