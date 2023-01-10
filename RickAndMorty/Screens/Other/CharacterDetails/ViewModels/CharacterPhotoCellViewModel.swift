//
//  CharacterPhotoCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/9/23.
//

import Foundation

final class CharacterPhotoCellViewModel {
	
	private let imageStringUrl: String
	
	init(imageUrl: String) {
		self.imageStringUrl = imageUrl
	}
	

	public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
		guard let url = URL(string: imageStringUrl) else {
			completion(.failure(URLError(.badURL)))
			return
		}
		ImageManager.shared.downloadImage(from: url, completion: completion)
	}
}
