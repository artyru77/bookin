//
//  LibraryViewController.swift
//  bookin
//
//  Created by Lukasz on 10/02/2017.
//  Copyright © 2017 candy bar code. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxDataSources

protocol LibraryViewControllerNavigationDelegate: class {
	func clickItem(with audiobook: Audiobook, at: UIViewController)
}

class LibraryViewController: UIViewController {

	private var tableView = LibraryTableView()

	private let disposeBag = DisposeBag()
	private let libraryViewModel: LibraryViewModel
	private var dataSource = Variable<[Audiobook]>([])

	weak var navigationDelegate: LibraryViewControllerNavigationDelegate?

	init(libraryViewModel: LibraryViewModel) {
		self.libraryViewModel = libraryViewModel
        super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = LibraryView()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setCustomTitleView(with: "Library")
		let v = view as! LibraryView
		tableView = v.tableView
		setupCollectionView()
		rx_setupTableView()
		rx_bindToDataSource()
    }

    private func setupCollectionView() {
        tableView.rowHeight = 80.0
		tableView.register(AudiobookCell.self, forCellReuseIdentifier: String(describing: AudiobookCell.self))
    }

	private func rx_setupTableView() {
        bindTableViewToLibrary()
        subscribeOnItemSelected()
	}

	private func rx_bindToDataSource() {
		libraryViewModel.libraryDBObservable()
			.subscribe(onNext: { (result, changeset) in
				if let changeset = changeset {
					self.dataSource.value = result
					print(changeset.deleted)
					print(changeset.inserted)
					print(changeset.updated)
				} else {
					self.dataSource.value = result
				}
			})
			.addDisposableTo(disposeBag)
	}

    private func bindTableViewToLibrary() {
        dataSource.asObservable()
			.bindTo(tableView.rx.items(cellIdentifier: "AudiobookCell")) { (index, audiobook, cell: AudiobookCell) in
				cell.title.text = audiobook.title
				cell.author.text = audiobook.author
				cell.imgView.image = audiobook.image
				index % 2 != 0 ? cell.setDarkWhiteBackground() : cell.setClearBackground()
			}.addDisposableTo(disposeBag)
    }

    private func subscribeOnItemSelected() {
		tableView.rx
			.itemSelected
			.map { return self.dataSource.value[$0.row] }
			.subscribe(onNext: { audiobook in
				self.navigationDelegate?.clickItem(with: audiobook, at: self)
				DispatchQueue.main.async {}
			}).addDisposableTo(disposeBag)
    }
}
