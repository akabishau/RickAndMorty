//
//  CharacterEpisodeCell.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/13/23.
//

import UIKit

class CharacterEpisodeCell: UICollectionViewCell {
	
	static let reuseId = String(describing: CharacterEpisodeCell.self)
	
	private let seasonLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 20, weight: .semibold)
		return label
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 22, weight: .regular)
		return label
	}()
	
	private let airDateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 18, weight: .light)
		return label
	}()
	
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.backgroundColor = .tertiarySystemBackground
		contentView.layer.cornerRadius = 8
		contentView.layer.borderWidth = 2
		layoutUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override func prepareForReuse() {
		super.prepareForReuse()
		nameLabel.text = nil
		seasonLabel.text = nil
		airDateLabel.text = nil
	}
	
	
	public func configure(with viewModel: CharacterEpisodeCellViewModel) {

		viewModel.registerForData { episode in
			self.nameLabel.text = episode.name
			self.seasonLabel.text = episode.episode
			self.airDateLabel.text = episode.air_date
		}
		
		// calling fetch but exiting early inside the funcion based on fetch flag
		viewModel.fetchEpisode()
	}
	
	
	private func layoutUI() {
		
		contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
		
		let padding: CGFloat = 8
		NSLayoutConstraint.activate([
			
			seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
			
			nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
			
			airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
			airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
		])
	}
}
