//
//  Service.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/26/22.
//

import Foundation


/// Primary API service object to get R&M data
final class Service {
	
	enum ServiceError: Error {
		case failedToCreateRequest
		case failedToGetData
	}
	
	
	/// Shared singleton instance
	static let shared = Service()
	
	/// Privatized constructor
	private init() { }
	
	
	/// Send R&M API call
	/// - Parameters:
	///   - request: Request instance (what is requested from api)
	///   - type: Expected Response Type (decoding to)
	///   - completion: Callback with data or error
	public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
		
		guard let urlRequest = self.request(from: request) else {
			completion(.failure(ServiceError.failedToCreateRequest))
			return
		}
		
		let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
			
			guard let data = data, error == nil else {
				completion(.failure(error ?? ServiceError.failedToGetData))
				return
			}
			
			do {
				let result = try JSONDecoder().decode(type.self, from: data)
				completion(.success(result))
			}
			catch {
				completion(.failure(error))
			}
		}
		task.resume()
	}
	
	
	// any pros of moving this code into a separate function?
	private func request(from rmRequest: RMRequest) -> URLRequest? {
		guard let url = rmRequest.url else { return nil }
		var request = URLRequest(url: url)
		request.httpMethod = rmRequest.httpMethod
		return request
	}
}
