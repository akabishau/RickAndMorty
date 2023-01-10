//
//  CharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/31/22.
//

import UIKit


class CharacterDetailViewViewModel {
	
	//MARK: - Private
	private let character: Character
	
	
	//MARK: - Init
	init(character: Character) {
		self.character = character
		setUpSections()
	}
	
	
	//MARK: - Public
	public var title: String {
		return character.name.uppercased()
	}
	
	//MARK: - Section Configuration
	enum SectionType {
		case photo(viewModel: CharacterPhotoCellViewModel)
		case info(viewModels: [CharacterInfoCellViewModel])
	}
	
	var sections: [SectionType] = []
	
	
	private func setUpSections() {
		sections = [
			.photo(viewModel: .init(imageUrl: character.image)),
			.info(viewModels:
					[.init(type: .status, value: character.status.rawValue),
					 .init(type: .gender, value: character.gender.rawValue),
					 .init(type: .type, value: character.type),
					 .init(type: .species, value: character.species),
					 .init(type: .origin, value: character.origin.name),
					 .init(type: .created, value: character.created),
					 .init(type: .location, value: character.location.name),
					 .init(type: .episodeCount, value: String(character.episode.count))
					])
		]
	}
	
	
	//MARK: - Compositional Layout
	public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
		
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
		
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
		let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		return section
	}
	
	
	public func createInfoSectionLayout() -> NSCollectionLayoutSection {
		
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
		let section = NSCollectionLayoutSection(group: group)
		return section
	}
}
