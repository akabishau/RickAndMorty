//
//  CharactersVC.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/25/22.
//

import UIKit

class CharactersVC: UIViewController {
	
	private let characterListView = CharacterListView()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Characters"
		setUpView()
	}
	
	private func setUpView() {
		characterListView.delegate = self
		view.addSubview(characterListView)
		
		NSLayoutConstraint.activate([
			characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}


extension CharactersVC: CharacterListViewDelegate {
	
	func characterListView(_ characterListView: CharacterListView, didSelect character: Character) {
		print(#function)
		
		let characterDetailVC = CharacterDetailVC()
		navigationController?.pushViewController(characterDetailVC, animated: true)
	}
}
