//
//  CharacterDetailVC.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/31/22.
//

import UIKit

class CharacterDetailVC: UIViewController {
	
	private let viewModel: CharacterDetailViewViewModel
	private let detailView: CharacterDetailView
	
	init(viewModel: CharacterDetailViewViewModel) {
		self.viewModel = viewModel
		self.detailView = CharacterDetailView(frame: .zero, viewModel: viewModel)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = viewModel.title
		view.backgroundColor = .systemBackground
		layoutUI()
		detailView.collectionView.dataSource = self
	}
	
	
	private func layoutUI() {
		detailView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(detailView)
		
		NSLayoutConstraint.activate([
			detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}


extension CharacterDetailVC: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return viewModel.sections.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let sectionType = viewModel.sections[section]
		switch sectionType {
			case .photo:
				return 1
			case .info(let infoViewModels):
				return infoViewModels.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let sectionType = viewModel.sections[indexPath.section]
		
		switch sectionType {
			case .photo(let photoCellViewModel):
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterPhotoCell.reuseId, for: indexPath) as! CharacterPhotoCell
				cell.configure(with: photoCellViewModel)
				return cell
			case .info(let infoViewModels):
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCell.reuseId, for: indexPath) as! CharacterInfoCell
				cell.configure(with: infoViewModels[indexPath.item])
				return cell
		}
	}
}
