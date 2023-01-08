//
//  CharacterListCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/29/22.
//

import Foundation


final class CharacterListCellViewModel: Hashable, Equatable {
	
	private let characterName: String
	private let characterStatus: CharacterStatus
	private let characterImageUrl: URL?
	
	init(characterName: String, characterStatus: CharacterStatus, characterImageUrl: URL?) {
		self.characterName = characterName
		self.characterStatus = characterStatus
		self.characterImageUrl = characterImageUrl
	}
	
	
	//MARK: - Hashable, Equatable
	func hash(into hasher: inout Hasher) {
		hasher.combine(characterName)
		hasher.combine(characterStatus)
		hasher.combine(characterImageUrl)
	}
	

	static func == (lhs: CharacterListCellViewModel, rhs: CharacterListCellViewModel) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
	
	
	//MARK: - Public
	public var characterNameText: String {
		return characterName.capitalized
	}
	
	
	public var characterStatusText: String {
		return "Status: \(characterStatus.rawValue.capitalized)"
	}
	
	
	//TODO: - Abstract to Image Manager
	public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {

		guard let url = characterImageUrl else {
			completion(.failure(URLError(.badURL)))
			return
		}
		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request) { data, _, error in
			
			guard let data = data, error == nil else {
				completion(.failure(URLError(.badServerResponse)))
				return
			}
			
			completion(.success(data))
			
		}.resume()
	}
}
