//
//  APICacheManager.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/14/23.
//

import Foundation

final class APICacheManager {
	
	
//	private var cache = NSCache<NSString, NSData>()
	
	private var cacheDictionary: [Endpoint: NSCache<NSString, NSData>] = [:]
	
	
	
	init() {
		setUpCache()
	}
	
	
	//MARK: - Public
	public func cachedResponse(for endpoint: Endpoint, url: URL?) -> Data? {
		guard let targetCache = cacheDictionary[endpoint] else {
			print("no target cache for endpoint:\(endpoint)")
			return nil
		}
		
		guard let url = url else { return nil }
		
		let key = url.absoluteString as NSString
		return targetCache.object(forKey: key) as? Data
	}
	
	
	public func setCache(for endpoint: Endpoint, url: URL?, data: Data) {
		guard let targetCache = cacheDictionary[endpoint] else {
			print("no target cache for endpoint:\(endpoint)")
			return
		}
		
		guard let url = url else { return }
		
		let key = url.absoluteString as NSString
		targetCache.setObject(data as NSData, forKey: key)
	}
	
	
	//MARK: - Private
	private func setUpCache() {
		Endpoint.allCases.forEach { endpoint in
			cacheDictionary[endpoint] = NSCache<NSString, NSData>()
		}
	}
}
