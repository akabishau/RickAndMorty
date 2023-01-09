//
//  CharacterListCell.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 12/29/22.
//

import UIKit

class CharacterListCell: UICollectionViewCell {
	
	static let reuseId = String(describing: CharacterListCell.self)
	
	let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = 8
		// apply corner radious for only top-left and top-right corners
		imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
		imageView.clipsToBounds = true
		return imageView
	}()
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .label
		label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		return label
	}()
	
	let statusLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .secondaryLabel
		label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		return label
	}()
	
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layoutUI()
		setUpCellLayer()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
		nameLabel.text = nil
		statusLabel.text = nil
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		setUpCellLayer()
	}

	
	public func configure(with viewModel: CharacterListCellViewModel) {
		
		nameLabel.text = viewModel.characterNameText
		statusLabel.text = viewModel.characterStatusText
		
		viewModel.fetchImage(completion: { [weak self] result in
			guard let self = self else { return }
			switch result {
				case .success(let data):
					DispatchQueue.main.async {
						self.imageView.image = UIImage(data: data)
					}
				case .failure(let error):
					print(String(describing: error))
			}
		})
	}
	
	private func setUpCellLayer() {
		contentView.backgroundColor = .secondarySystemBackground
		contentView.layer.cornerRadius = 8
		
		// when clipsToBounds is true the shadows are hidden
		contentView.layer.shadowColor = UIColor.label.cgColor
		contentView.layer.shadowOffset = .init(width: 2, height: 2)
		contentView.layer.shadowOpacity = 0.3
	}
	
	
	private func layoutUI() {
		contentView.addSubviews(imageView, nameLabel, statusLabel)
		
		NSLayoutConstraint.activate([
			statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			statusLabel.heightAnchor.constraint(equalToConstant: 30),
			
			nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
			nameLabel.heightAnchor.constraint(equalToConstant: 30),
			
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor)
		])
	}
}
