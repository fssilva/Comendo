//
//  SortingValues.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation
struct SortingValues : Codable {
	let bestMatch : Double?
	let newest : Double?
	let ratingAverage : Double?
	let distance : Int?
	let popularity : Double?
	let averageProductPrice : Int?
	let deliveryCosts : Int?
	let minCost : Int?
    
    var description: String {
        var desc = ""
        if let bm = bestMatch{
            desc += "Best match: \(bm)\n"
        }
        if let n = newest{
            desc += "Newest: \(n)\n"
        }
        if let d = distance{
            desc += "Distance: \(d)\n"
        }
        if let p = popularity{
            desc += "Popularity: \(p)\n"
        }
        if let ap = averageProductPrice {
            desc += "Average Product: \(ap)\n"
        }
        if let dc = deliveryCosts {
            desc += "Delivery Costs: \(dc)\n"
        }
        if let min = minCost {
            desc += "Min Cost: \(min)\n"
        }
        
        return desc
        
    }

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
    
    init(bestMatch:Double, newest: Double, ratingAverage: Double, distance: Int, popularity: Double,
         averageProductPrice: Int, deliveryCosts: Int, minCost: Int) {
        self.bestMatch = bestMatch
        self.newest = newest
        self.ratingAverage = ratingAverage
        self.distance = distance
        self.popularity = popularity
        self.averageProductPrice = averageProductPrice
        self.deliveryCosts = deliveryCosts
        self.minCost = minCost
    }

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bestMatch = try values.decodeIfPresent(Double.self, forKey: .bestMatch)
		newest = try values.decodeIfPresent(Double.self, forKey: .newest)
		ratingAverage = try values.decodeIfPresent(Double.self, forKey: .ratingAverage)
		distance = try values.decodeIfPresent(Int.self, forKey: .distance)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		averageProductPrice = try values.decodeIfPresent(Int.self, forKey: .averageProductPrice)
		deliveryCosts = try values.decodeIfPresent(Int.self, forKey: .deliveryCosts)
		minCost = try values.decodeIfPresent(Int.self, forKey: .minCost)
	}

}
