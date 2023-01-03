//
//  ListFooterLoadingView.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/3/23.
//

import UIKit

class ListFooterLoadingView: UICollectionReusableView {
	
	static let reuseId = String(describing: ListFooterLoadingView.self)
	
	private let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.hidesWhenStopped = true
		return spinner
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .systemBackground
		
		layoutView()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func layoutView() {
		
		addSubview(spinner)
		
		NSLayoutConstraint.activate([
			spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
	
	
	public func startAnimating() {
		spinner.startAnimating()
	}
}
