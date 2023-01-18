//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/1/23.
//

import UIKit

class CharacterDetailView: UIView {
	
	private let viewModel: CharacterDetailViewViewModel
	
	// public - to be able to set delegate and data source on view controller
	public var collectionView: UICollectionView!
	
	//MARK: - Init
	init(frame: CGRect, viewModel: CharacterDetailViewViewModel) {
		self.viewModel = viewModel
		super.init(frame: frame)
		
		createCollectionView()
		layoutUI()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	//MARK: - Collection View
	private func createCollectionView() {
		// create comp layout
		let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
			return self.createLayoutSection(for: sectionIndex)
		}
		// configure collectio view with the layout
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(CharacterPhotoCell.self, forCellWithReuseIdentifier: CharacterPhotoCell.reuseId)
		collectionView.register(CharacterInfoCell.self, forCellWithReuseIdentifier: CharacterInfoCell.reuseId)
		collectionView.register(CharacterEpisodeCell.self, forCellWithReuseIdentifier: CharacterEpisodeCell.reuseId)
		self.collectionView = collectionView
	}
	
	
	private func createLayoutSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
		let sectionType = viewModel.sections[sectionIndex]
		switch sectionType {
			case .photo:
				return viewModel.createPhotoSectionLayout()
			case .info:
				return viewModel.createInfoSectionLayout()
			case .episode:
				return viewModel.createEpisodeSectionLayout()
		}
	}
	
	
	//MARK: - Autolayout
	private func layoutUI() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
