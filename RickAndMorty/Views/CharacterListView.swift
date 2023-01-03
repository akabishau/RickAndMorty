//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/28/22.
//

import UIKit

protocol CharacterListViewDelegate: AnyObject {
	// standard naming convention for view protocol (similar to collection view)
	func characterListView(_ characterListView: CharacterListView, didSelect character: Character)
}

final class CharacterListView: UIView {
	
	private let viewModel = CharacterListViewViewModel()
	
	public weak var delegate: CharacterListViewDelegate?
	
	
	private let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.hidesWhenStopped = true
		spinner.startAnimating()
		return spinner
	}()
	
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.sectionInset = .init(top: 0, left: 10, bottom: 10, right: 10)
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(CharacterListCell.self, forCellWithReuseIdentifier: CharacterListCell.reuseId)
		collectionView.register(ListFooterLoadingView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ListFooterLoadingView.reuseId)
		collectionView.isHidden = true
		collectionView.alpha = 0
		return collectionView
	}()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		viewModel.delegate = self
		viewModel.fetchCharacters()
		layoutUI()
		setUpCollectionView()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func setUpCollectionView() {
		collectionView.dataSource = viewModel
		collectionView.delegate = viewModel
	}
	
	
	private func layoutUI() {
		translatesAutoresizingMaskIntoConstraints = false
		
		addSubviews(spinner, collectionView)
		
		NSLayoutConstraint.activate([
			spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
			
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}


extension CharacterListView: CharacterListViewViewModelDelegate {
	
	func didLoadInitialCharacters() {
		collectionView.reloadData()
		spinner.stopAnimating()
		
		UIView.animate(withDuration: 0.4) {
			self.collectionView.isHidden = false
			self.collectionView.alpha = 1
		}
	}
	
	
	func didSelectCharacter(_ character: Character) {
		print(#function)
		delegate?.characterListView(self, didSelect: character)
	}
}
