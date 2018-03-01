//
//  MockingRestaurantService.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation

class MockRestaurantsService: RestaurantsService {
    
    enum Error: Swift.Error {
        case fetchFailed
    }
    
    let delay: TimeInterval?
    let restaurants: [Restaurant]
    let sortingKeys: [String]
    let errorRate: Float
    
    init(restaurants: [Restaurant] = MockRestaurantsService.makeMockRestaurants(),
         sortingKeys: [String] = MockRestaurantsService.makeMockSortingKeys(),
         delay: TimeInterval? = nil,
         errorRate: Float = 0.0) {
        self.delay = delay
        self.restaurants = restaurants
        self.sortingKeys = sortingKeys
        self.errorRate = errorRate
    }
    
    func fetchRestaurants(_ completion: @escaping ((Result<[Restaurant]>) -> Void)) {
        executeInMock(afterDelay: delay) { [weak self] in
            guard let strongSelf = self else { return }
                completion(Result.success(strongSelf.restaurants))
        }
    }
    
    func fetchSortingKeys(_ completion: @escaping ((Result<[String]>) -> Void)) {
        executeInMock(afterDelay: delay) { [weak self] in
            guard let strongSelf = self else { return }
            completion(Result.success(strongSelf.sortingKeys))
        }
    }
    
    static func makeMockSortingKeys() -> [String]  {
        let path = Bundle.main.path(forResource: "sortingkeys", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path)) //Taking a shortcut since the file is staticaly embedded.
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let keys = try! decoder.decode(SortingKeys.self, from: data)
        return keys.sortingkeys!
    }
    
    static func makeMockRestaurants() -> [Restaurant] {
        
        let path = Bundle.main.path(forResource: "content", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path)) //Taking a shortcut since the file is staticaly embedded.
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let comida = try! decoder.decode(ComidaDataModel.self, from: data)
        return comida.restaurants!
    }
    
}
