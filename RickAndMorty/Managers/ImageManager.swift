//
//  ImageManager.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/8/23.
//

import UIKit

final class ImageManager {
	
	static let shared = ImageManager()
	private init() { }
	
	
	private let imageDataCache = NSCache<NSString, NSData>()
	
	
	public func downloadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
		print(#function)
		let key = url.absoluteString as NSString
		
		if let data = imageDataCache.object(forKey: key) {
			completion(.success(data as Data))
			return
		}
		
		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
			guard let self = self else { return }
			guard let data = data, error == nil else {
				completion(.failure(URLError(.badServerResponse)))
				return
			}
			let value = data as NSData
			self.imageDataCache.setObject(value, forKey: key)
			completion(.success(data))
		}.resume()
	}
}
