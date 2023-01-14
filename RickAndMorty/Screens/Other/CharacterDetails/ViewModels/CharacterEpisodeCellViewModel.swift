//
//  CharacterEpisodeCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/13/23.
//

import Foundation


// protocol to only show data point to the cell to render ui
protocol EpisodeDataRender {
	var episode: String { get }
	var name: String { get }
	var air_date: String { get }
}

final class CharacterEpisodeCellViewModel {
	
	private let episodeUrl: String
	
	private var isFetching = false
	
	private var dataBlock: ((EpisodeDataRender) -> Void)?
	private var episode: Episode? {
		didSet {
			guard let model = episode else { return }
			dataBlock?(model)
		}
	}
	
	
	
	init(episodeUrl: String) {
		self.episodeUrl = episodeUrl
	}
	
	
	// publisher/subscriber pattern
	public func registerForData(_ block: @escaping (EpisodeDataRender) -> Void) {
		self.dataBlock = block
	}
	
	
	
	public func fetchEpisode() {
		
		if isFetching {
			guard let episode = episode else { return }
			dataBlock?(episode)
			return
		}
		
		guard let url = URL(string: episodeUrl) else { return }
		guard let episodeRequest = RMRequest(url: url) else { return }
		
		isFetching = true
		
		Service.shared.execute(episodeRequest, expecting: Episode.self) { [weak self] result in
			switch result {
				case .success(let response):
					DispatchQueue.main.async {
						self?.episode = response
					}
				case .failure(let error):
					print(error)
			}
		}
	}
}
