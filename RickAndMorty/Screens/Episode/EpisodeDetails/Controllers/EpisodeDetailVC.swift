//
//  EpisodeDetailVC.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/13/23.
//

import UIKit

final class EpisodeDetailVC: UIViewController {
	
	private let viewModel: EpisodeDetailViewViewModel
	
	//TODO: Can I pass the string instead of URL (in tutorial)?
	init(episodeStringUrl: String) {
		self.viewModel = EpisodeDetailViewViewModel(episodeStringUrl: episodeStringUrl)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		viewModel.fetchEpisodeData()
	}
}
