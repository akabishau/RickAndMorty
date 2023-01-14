//
//  Episode.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/26/22.
//

import Foundation

struct Episode: Codable, EpisodeDataRender {
	let id: Int
	let name: String
	let air_date: String
	let episode: String
	let characters: [String]
	let url: String
	let created: String
}
