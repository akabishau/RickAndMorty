//
//  EpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/14/23.
//

import Foundation

final class EpisodeDetailViewViewModel {
	
	private let episodeStringUrl: String
	
	init(episodeStringUrl: String) {
		self.episodeStringUrl = episodeStringUrl
	}
	
	
	func fetchEpisodeData() {
		guard let url = URL(string: episodeStringUrl) else { return }
		guard let request = RMRequest(url: url) else { return }
		
		Service.shared.execute(request, expecting: Episode.self) { result in
			switch result {
				case .success(let episode):
					print(episode.name)
				case .failure(let error):
					print(error)
			}
		}
	}
}
