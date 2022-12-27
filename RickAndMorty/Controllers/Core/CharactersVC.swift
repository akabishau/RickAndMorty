//
//  CharactersVC.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/25/22.
//

import UIKit

class CharactersVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Characters"
		
		let request = RMRequest(endpoint: .character, queryParameters: [URLQueryItem(name: "name", value: "rick")])
		
		
		Service.shared.execute(request, expecting: AllCharactersResponse.self) { result in
			switch result {
				case .success(let model):
					print(String(describing: model.info.count))
					model.results.forEach({ print($0.name)})
//					print(model.results.forEach({ $0.name }))
				case .failure(let error):
					print(error)
			}
		}
	}
}
