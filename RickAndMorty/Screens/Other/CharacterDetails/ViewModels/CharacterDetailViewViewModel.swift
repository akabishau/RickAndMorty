//
//  CharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/31/22.
//

import Foundation


class CharacterDetailViewViewModel {
	
	private let character: Character
	
	init(character: Character) {
		self.character = character
	}
	
	
	public var title: String {
		return character.name.uppercased()
	}
}
