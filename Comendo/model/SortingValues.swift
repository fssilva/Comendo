//
//  SortingValues.swift
//  Comendo
//
//  Created by Felipe de Sousa Silva on 08.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation
struct SortingValues : Codable {
	let bestMatch : Int?
	let newest : Int?
	let ratingAverage : Double?
	let distance : Int?
	let popularity : Int?
	let averageProductPrice : Int?
	let deliveryCosts : Int?
	let minCost : Int?

	enum CodingKeys: String, CodingKey {

		case bestMatch = "bestMatch"
		case newest = "newest"
		case ratingAverage = "ratingAverage"
		case distance = "distance"
		case popularity = "popularity"
		case averageProductPrice = "averageProductPrice"
		case deliveryCosts = "deliveryCosts"
		case minCost = "minCost"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bestMatch = try values.decodeIfPresent(Int.self, forKey: .bestMatch)
		newest = try values.decodeIfPresent(Int.self, forKey: .newest)
		ratingAverage = try values.decodeIfPresent(Double.self, forKey: .ratingAverage)
		distance = try values.decodeIfPresent(Int.self, forKey: .distance)
		popularity = try values.decodeIfPresent(Int.self, forKey: .popularity)
		averageProductPrice = try values.decodeIfPresent(Int.self, forKey: .averageProductPrice)
		deliveryCosts = try values.decodeIfPresent(Int.self, forKey: .deliveryCosts)
		minCost = try values.decodeIfPresent(Int.self, forKey: .minCost)
	}

}
