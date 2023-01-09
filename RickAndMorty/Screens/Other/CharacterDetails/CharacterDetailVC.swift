//
//  CharacterDetailVC.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/31/22.
//

import UIKit

class CharacterDetailVC: UIViewController {
	
	private let viewModel: CharacterDetailViewViewModel
	
	init(viewModel: CharacterDetailViewViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = viewModel.title
		view.backgroundColor = .systemBackground
	}
}
