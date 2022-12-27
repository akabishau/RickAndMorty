//
//  AllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/27/22.
//

import Foundation


struct AllCharactersResponse: Codable {
	struct Info: Codable {
		let count: Int
		let pages: Int
		let next: String?
		let prev: String?
	}
	
	let info: Info
	let results: [Character]
}
