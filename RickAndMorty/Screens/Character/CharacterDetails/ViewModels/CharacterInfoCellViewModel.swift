//
//  CharacterInfoCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleksey Kabishau on 1/10/23.
//

import UIKit


final class CharacterInfoCellViewModel {
	
	//MARK: - Private
	private let type: `Type`
	private let value: String
	
	//MARK: - Init
	init(type: `Type`, value: String) {
		self.type = type
		self.value = value
	}
	
	//MARK: - Public
	var title: String {
		return type.displayTitle
	}
	
	var displayValue: String {
		if value.isEmpty { return "None" }
		if type == .created {
			if let date = Self.dateFormatter.date(from: value) {
				print(value)
				return Self.shortDateFormatter.string(from: date)
			}
		}
		return value.capitalized
	}
	
	var iconImage: UIImage? {
		return type.iconImage
	}
	
	var tintColor: UIColor {
		return type.tintColor
	}
	
	
	//MARK: - Date Formatter
	// static because "it's expensive", why?
	static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
		formatter.timeZone = .current
		return formatter
	}()
	
	static let shortDateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .short
		formatter.timeZone = .current
		return formatter
	}()
	
	
	//MARK: - Type
	enum `Type`: String {
		case status
		case gender
		case type
		case species
		case origin
		case created
		case location
		case episodeCount
		
		
		var displayTitle: String {
			switch self {
				case .episodeCount: return "EPISODE COUNT"
				default: return rawValue.uppercased()
			}
		}
		
		var iconImage: UIImage? {
			switch self {
				case .status:
					return UIImage(systemName: "bolt.heart")
				case .gender:
					return UIImage(systemName: "figure.dress.line.vertical.figure")
				case .type:
					return UIImage(systemName: "circle.grid.cross")
				case .species:
					return UIImage(systemName: "person.3")
				case .origin:
					return UIImage(systemName: "smallcircle.filled.circle")
				case .created:
					return UIImage(systemName: "plus.square")
				case .location:
					return UIImage(systemName: "globe.americas")
				case .episodeCount:
					return UIImage(systemName: "number.circle")
			}
		}

		var tintColor: UIColor {
			switch self {
				case .status:
					return .systemBlue
				case .gender:
					return .systemRed
				case .type:
					return .systemPurple
				case .species:
					return .systemGreen
				case .origin:
					return .systemOrange
				case .created:
					return .systemPink
				case .location:
					return .systemYellow
				case .episodeCount:
					return .systemMint
			}
		}
	}
}
