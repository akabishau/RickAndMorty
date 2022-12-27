//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/26/22.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
	
	private struct Constants {
		static let baseURL = "https://rickandmortyapi.com/api"
	}
	private let baseUrl = "rickandmortyapi.com"
	private let endpoint: Endpoint
	private let pathComponents: [String]
	private let queryParameters: [URLQueryItem]
	
	
	//TODO: - Refactor using URL Components
	private var urlString: String {
		var string = Constants.baseURL
		string += "/"
		string += endpoint.rawValue
		
		if !pathComponents.isEmpty {
			pathComponents.forEach({ string += "/\($0)"})
		}
		
		if !queryParameters.isEmpty {
			string += "?"
			let argumentString = queryParameters.compactMap { queryItem in
				guard let value = queryItem.value else { return nil }
				return "\(queryItem.name)=\(value)"
			}.joined(separator: "&")
			string += argumentString
		}
		
		return string
	}
	
	
	public var url: URL? {
		return URL(string: urlString)
	}
	
	public let httpMethod = "GET"
	
	
	
	public init(endpoint: Endpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
		self.endpoint = endpoint
		self.pathComponents = pathComponents
		self.queryParameters = queryParameters
	}
	
}


extension RMRequest {
	static let characterList = RMRequest(endpoint: .character)
}
