//
//  CharacterEpisodeCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/13/23.
//

import Foundation

final class CharacterEpisodeCellViewModel {
	
	private let episodeUrl: String
	
	init(episodeUrl: String) {
		self.episodeUrl = episodeUrl
	}
	
	
	public func fetchEpisode() {
		print(#function)
		guard let url = URL(string: episodeUrl) else {
			print("invalid url")
			return
		}
		print(url)
	}
}
