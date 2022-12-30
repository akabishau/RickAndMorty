//
//  Character.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/26/22.
//

import Foundation


struct Character: Codable {
	let id: Int
	let name: String
	let status: CharacterStatus
	let species: String
	let type: String
	let gender: CharacterGender
	let origin: Origin
	let location: SingleLocation
	let image: String
	let episode: [String]
	let url: String
	let created: String
}


struct Origin: Codable {
	let name: String
	let url: String
	
}

struct SingleLocation: Codable {
	let name: String
	let url: String
}

enum CharacterGender: String, Codable {
	case male = "Male"
	case female = "Female"
	case genderless = "Genderless"
	case `unknown` = "unknown" //using ` to avoid potential issues with Swift keyword "unknown"
}


enum CharacterStatus: String, Codable {
	case alive = "Alive"
	case dead = "Dead"
	case `unknown` = "unknown" // using ` to avoid potential issues with Swift keyword "unknown"
}
