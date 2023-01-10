//
//  CharacterInfoCell.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/10/23.
//

import UIKit

class CharacterInfoCell: UICollectionViewCell {
	
	static let reuseId = String(describing: CharacterInfoCell.self)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layoutUI()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
	}
	
	public func configure(with viewModel: CharacterInfoCellViewModel) {
		
	}
	
	private func layoutUI() {
		
		contentView.backgroundColor = .systemOrange
		
	}
}
