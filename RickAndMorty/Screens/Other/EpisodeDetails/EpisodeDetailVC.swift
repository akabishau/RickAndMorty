//
//  EpisodeDetailVC.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/13/23.
//

import UIKit

final class EpisodeDetailVC: UIViewController {
	
	private let episodeStringUrl: String
	
	
	init(episodeStringUrl: String) {
		self.episodeStringUrl = episodeStringUrl
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground

	}
}
