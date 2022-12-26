//
//  Service.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/26/22.
//

import Foundation


/// Primary API service object to get R&M data
final class Service {
	
	/// Sahred singleton instance
	static let shared = Service()
	
	
	/// Privatized constructor
	private init() { }
	
	
	/// Send R&M API call
	/// - Parameters:
	///   - request: Request instance
	///   - completion: Callback with data or error
	public func execute(_ request: Request, completion: @escaping () -> Void) {
		
	}
}


final class Request {
	
}
