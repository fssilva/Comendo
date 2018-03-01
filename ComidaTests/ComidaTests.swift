//
//  ComidaTests.swift
//  ComidaTests
//
//  Created by Felipe de Sousa Silva on 08.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import XCTest
import CoreArchitecture
@testable import Comida

class ComidaTests: XCTestCase {
    
    var component: RestaurantListComponent!
    var core: Core!
    
    override func setUp() {
        super.setUp()
        
        let restService = MockRestaurantsService(delay: nil)
        let navigator = RestaurantListNavigator()
        component = RestaurantListComponent(service: restService, navigator: navigator)
        core = Core(rootComponent: component)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRestaurantListFetch() {
        // Request Restaurants:
        core.dispatch(component.fetchCommand())
        XCTAssertNotEqual(component.state.restaurants.count, 0)
        XCTAssertNotEqual(component.state.sortingFilters.count, 0)
        
        //XCTAssertEqual(restComponent.state.restaurants.count, 0) // This fails

    }
    
}
