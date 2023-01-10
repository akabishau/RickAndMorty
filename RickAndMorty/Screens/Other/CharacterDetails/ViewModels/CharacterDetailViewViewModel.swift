//
//  CharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/31/22.
//

import UIKit


class CharacterDetailViewViewModel {
	
	private let character: Character
	
	init(character: Character) {
		self.character = character
		setUpSections()
	}
	
	
	public var title: String {
		return character.name.uppercased()
	}
	
	//MARK: - Section Configuration
	enum SectionType {
		case photo(viewModel: CharacterPhotoCellViewModel)
	}
	
	var sections: [SectionType] = []
	
	
	private func setUpSections() {
		sections = [
			.photo(viewModel: .init(imageUrl: character.image))
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
}
