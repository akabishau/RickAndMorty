//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/28/22.
//

import UIKit

final class CharacterListView: UIView {
	
	private let viewModel = CharacterListViewViewModel()
	
	
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
		layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(CharacterListCell.self, forCellWithReuseIdentifier: CharacterListCell.reuseId)
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
}
