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
	public let endpoint: Endpoint // exposed to cache manager
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
	
	
	//TODO: - Try to refactor using URL Components
	// failable init - parsing string url to initialize RMRequest using endpoint and query items
	convenience init?(url: URL) {
		let string = url.absoluteString
		if !string.contains(Constants.baseURL) {
			return nil
		}
		let trimmed = string.replacingOccurrences(of: Constants.baseURL+"/", with: "")
		if trimmed.contains("/") {
			let components = trimmed.components(separatedBy: "/")
			if !components.isEmpty {
				let endpointString = components[0] // Endpoint
				var pathComponents: [String] = []
				if components.count > 1 {
					pathComponents = components
					pathComponents.removeFirst()
				}
				if let endpoint = Endpoint(rawValue: endpointString) {
					self.init(endpoint: endpoint, pathComponents: pathComponents)
					return
				}
			}
		} else if trimmed.contains("?") {
			let components = trimmed.components(separatedBy: "?")
			if !components.isEmpty, components.count >= 2 {
				let endpointString = components[0]
				let queryItemsString = components[1]
				let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
					guard $0.contains("=") else {
						return nil
					}
					let parts = $0.components(separatedBy: "=")
					
					return URLQueryItem(
						name: parts[0],
						value: parts[1]
					)
				})
				
				if let endpoint = Endpoint(rawValue: endpointString) {
					self.init(endpoint: endpoint, queryParameters: queryItems)
					return
				}
			}
		}
		return nil
	}
}


extension RMRequest {
	static let characterList = RMRequest(endpoint: .character)
}
