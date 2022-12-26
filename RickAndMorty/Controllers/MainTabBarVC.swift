//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/25/22.
//

import UIKit

final class MainTabBarVC: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpTabs()
	}
	
	
	private func setUpTabs() {
		
		let charactersVC = CharactersVC()
		let locationsVC = LocationsVC()
		let episodesVC = EpisodesVC()
		let settingVC = SettingsVC()
		
		for viewController in [charactersVC, locationsVC, episodesVC, settingVC] {
			viewController.navigationItem.largeTitleDisplayMode = .automatic
			viewController.view.backgroundColor = .systemBackground
		}
		
		
		let charactersNC = UINavigationController(rootViewController: charactersVC)
		let locationsNC = UINavigationController(rootViewController: locationsVC)
		let episodesNC = UINavigationController(rootViewController: episodesVC)
		let settingNC = UINavigationController(rootViewController: settingVC)
		
		
		charactersNC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
		locationsNC.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
		episodesNC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
		settingNC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
		
		
		for navController in [charactersNC, locationsNC, episodesNC, settingNC] {
			navController.navigationBar.prefersLargeTitles = true
		}
		
		
		setViewControllers([charactersNC, locationsNC, episodesNC, settingNC], animated: true)
	}
}

