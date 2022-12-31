//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/28/22.
//

import UIKit


protocol CharacterListViewViewModelDelegate: AnyObject {
	func didLoadInitialCharacters()
	func didSelectCharacter(_ character: Character)
}

final class CharacterListViewViewModel: NSObject {
	
	public weak var delegate: CharacterListViewViewModelDelegate?
	
	private var characters: [Character] = [] {
		didSet {
			for character in characters {
				let viewModel = CharacterListCellViewModel(
					characterName: character.name,
					characterStatus: character.status,
					characterImageUrl: URL(string: character.image))
				cellViewModels.append(viewModel)
			}
		}
	}
	
	// using this to add more models when the data for the next page fetched
	private var cellViewModels: [CharacterListCellViewModel] = []
	
	public func fetchCharacters() {
		
		let request = RMRequest(endpoint: .character, queryParameters: [URLQueryItem(name: "name", value: "rick")])
		
		Service.shared.execute(request, expecting: AllCharactersResponse.self) { [weak self] result in
			guard let self = self else { return }
			switch result {
				case .success(let responseModel):
					self.characters = responseModel.results
					DispatchQueue.main.async {
						self.delegate?.didLoadInitialCharacters()
					}
				case .failure(let error):
					print(error)
			}
		}
	}
}


extension CharacterListViewViewModel: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(#function)
		//TODO: - review using characters after implementing infinite scrolling
		let character = characters[indexPath.item]
		delegate?.didSelectCharacter(character)
	}
}


extension CharacterListViewViewModel: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellViewModels.count
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterListCell.reuseId, for: indexPath) as! CharacterListCell
		cell.configure(with: cellViewModels[indexPath.item])
		return cell
	}
}


extension CharacterListViewViewModel: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellWidth = (UIScreen.main.bounds.width - 30) / 2
		return .init(width: cellWidth, height: cellWidth * 1.5)
	}
}
