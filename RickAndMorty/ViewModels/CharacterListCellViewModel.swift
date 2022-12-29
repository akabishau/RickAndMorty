//
//  CharacterListCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/29/22.
//

import Foundation


final class CharacterListCellViewModel {
	
	private let characterName: String
	private let characterStatus: CharacterStatus
	private let characterImageUrl: URL?
	
	init(characterName: String, characterStatus: CharacterStatus, characterImageUrl: URL?) {
		self.characterName = characterName
		self.characterStatus = characterStatus
		self.characterImageUrl = characterImageUrl
	}
	
	
	public var characterNameText: String {
		return characterName.capitalized
	}
	
	
	public var characterStatusText: String {
		return characterStatus.rawValue
	}
	
	
	//TODO: - Abstract to Image Manager
	public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {

		guard let url = characterImageUrl else {
			completion(.failure(URLError(.badURL)))
			print("image url")
			return
		}
		print(url)
		let request = URLRequest(url: url)
		print(request)
		URLSession.shared.dataTask(with: request) { data, _, error in
			
			guard let data = data, error == nil else {
				completion(.failure(URLError(.badServerResponse)))
				print("bad response")
				return
			}
			
			completion(.success(data))
			
		}.resume()
	}
}
