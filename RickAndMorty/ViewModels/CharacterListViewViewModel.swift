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
	
	
	/// Fetch the intial set of characters
	public func fetchCharacters() {
		
		let request = RMRequest(endpoint: .character, queryParameters: [URLQueryItem(name: "name", value: "rick")])
		
		Service.shared.execute(request, expecting: AllCharactersResponse.self) { [weak self] result in
			guard let self = self else { return }
			switch result {
				case .success(let responseModel):
					self.characters = responseModel.results
					self.apiInfo = responseModel.info
					DispatchQueue.main.async {
						self.delegate?.didLoadInitialCharacters()
					}
				case .failure(let error):
					print(error)
			}
		}
	}
	
	
	// MARK: - Additional Character Load
	
	private var apiInfo: AllCharactersResponse.Info? = nil
	private var isLoadingMoreCharacters = false
	public var shouldShowLoadMoreIndicator: Bool {
		return apiInfo?.next != nil
	}
	
	/// Paginate if additional characters are needed
	public func fetchAdditionalCharacters() {
		isLoadingMoreCharacters = true
		print(#function)
	}
}

//MARK: - Collection View

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
	
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		guard kind == UICollectionView.elementKindSectionFooter else {
			return UICollectionReusableView(frame: .zero)
		}
		
		let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ListFooterLoadingView.reuseId, for: indexPath) as! ListFooterLoadingView
		footer.startAnimating()
		return footer
	}
}


extension CharacterListViewViewModel: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellWidth = (UIScreen.main.bounds.width - 30) / 2
		return .init(width: cellWidth, height: cellWidth * 1.5)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		if !shouldShowLoadMoreIndicator {
			return .zero
		}
		return CGSize(width: collectionView.frame.width, height: 100)
	}
}


//MARK: - Scroll View

extension CharacterListViewViewModel: UIScrollViewDelegate {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		// the second condition allows to avoid multiple fetching requests
		guard shouldShowLoadMoreIndicator, !isLoadingMoreCharacters else { return }
		
		let offset = scrollView.contentOffset.y
		let totalContentHeight = scrollView.contentSize.height
		let totalScrollViewFixedHeight = scrollView.frame.size.height
		
		// this logic show when scrolling reached the bottom of the scroll view
		if offset >= (totalContentHeight - totalScrollViewFixedHeight) {
			print("load next set of data")
			fetchAdditionalCharacters()
		}
		print(offset, totalContentHeight, totalScrollViewFixedHeight)
	}
}
