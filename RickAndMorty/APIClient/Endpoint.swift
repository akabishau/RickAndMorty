//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/26/22.
//

import Foundation

/// Respresents unique API endpoints
@frozen enum Endpoint: String, Hashable, CaseIterable {
	case character
	case location
	case episode
}
