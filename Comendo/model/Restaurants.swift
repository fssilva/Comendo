//
//  Restaurant.swift
//  Comendo
//
//  Created by Felipe de Sousa Silva on 08.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation
struct Restaurant : Codable {
	let name : String?
	let status : String?
	let sortingValues : SortingValues?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case status = "status"
		case sortingValues
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		sortingValues = try SortingValues(from: decoder)
	}

}
