//
//  CharacterPhotoCell.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/9/23.
//

import UIKit

final class CharacterPhotoCell: UICollectionViewCell {
	
	static let reuseId = String(describing: CharacterPhotoCell.self)
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = .systemOrange
		imageView.clipsToBounds = true
		return imageView
	}()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layoutUI()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
		
	}
	
	
	public func configure(with viewModel: CharacterPhotoCellViewModel) {
		viewModel.fetchImage { [weak self] result in
			switch result {
				case .success(let imageData):
					DispatchQueue.main.async {
						self?.imageView.image = UIImage(data: imageData)
					}
				case .failure(let error):
					print("couldn't get character image", error)
			}
		}
	}
	
	
	private func layoutUI() {
		contentView.addSubview(imageView)
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
