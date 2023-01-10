//
//  CharacterInfoCell.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/10/23.
//

import UIKit

class CharacterInfoCell: UICollectionViewCell {
	
	static let reuseId = String(describing: CharacterInfoCell.self)
	
	
	private let titleContainerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .secondarySystemBackground
		return view
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 20, weight: .medium)
		return label
	}()
	
	private let valueLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 20, weight: .light)
		return label
	}()
	
	private let iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.backgroundColor = .secondarySystemFill
		contentView.layer.cornerRadius = 6
		contentView.clipsToBounds = true
		layoutUI()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func prepareForReuse() {
		super.prepareForReuse()
		titleLabel.text = nil
		valueLabel.text = nil
		iconImageView.image = nil
		iconImageView.tintColor = .label
		titleLabel.tintColor = .label
	}
	
	
	public func configure(with viewModel: CharacterInfoCellViewModel) {
		titleLabel.text = viewModel.title
		valueLabel.text = viewModel.displayValue
		iconImageView.image = viewModel.iconImage
		iconImageView.tintColor = viewModel.tintColor
		titleLabel.textColor = viewModel.tintColor
	}
	
	
	private func layoutUI() {
		contentView.addSubviews(iconImageView, valueLabel, titleContainerView)
		titleContainerView.addSubview(titleLabel)
		
		NSLayoutConstraint.activate([
			titleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
			
			titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
			titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
			
			iconImageView.heightAnchor.constraint(equalToConstant: 30),
			iconImageView.widthAnchor.constraint(equalToConstant: 30),
			iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			iconImageView.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor,constant: -8),
			
//			valueLabel.heightAnchor.constraint(equalTo: iconImageView.heightAnchor),
			valueLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
			valueLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
			valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			valueLabel.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor),
		])
	}
}
