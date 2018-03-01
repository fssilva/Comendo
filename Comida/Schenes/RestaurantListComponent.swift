//
//  RestaurantListComponent.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation
import CoreArchitecture

// MARK: - State

struct RestaurantListState: State {
    
    enum Change {
        case loadingState
        case restaurants(CollectionChange)
        case error
    }
    
    var loadingState = ActivityTracker()
    var restaurants: [Restaurant] = []
    var sortingFilters: [String] = []
    var currentSortingFilter: String?
    var error: Error? = nil
    var changelog: [Change] = [.loadingState, .restaurants(.reload), .error]
}

// MARK: - Actions

enum RestaurantListAction: Action {
    case favoriteRestaurant(Restaurant, Bool)
    case saveSortFilter(String)
    case reloadFilters([String])
    case reloadRestaurants([Restaurant])
    case addRestaurant(Restaurant)
    case removeRestaurant(index: Int)
    case addActivity
    case removeActivity
    case error(Error)
}

enum RestaurantListNavigatorAction: Action {
    case detail(Restaurant)
}

// MARK: - Component

class RestaurantListComponent: Component<RestaurantListState> {
    
    let service: RestaurantsService
    let navigator: Navigator
    
    init(service: RestaurantsService, navigator: Navigator) {
        self.service = service
        self.navigator = navigator
        super.init(state: RestaurantListState())
    }
    
    override func process(_ action: Action) {
        if let navigation = navigator.resolve(action) {
            commit(navigation)
        } else {
            guard let action = action as? RestaurantListAction else { return }
            var state = self.state
            state.changelog = []
            
            switch action {
            case .favoriteRestaurant(let restaurant, let favorite):
                if favorite {
                    Percistence.shared.favoriteItem(key: restaurant.name!)
                }else {
                    Percistence.shared.unfavoriteItem(key: restaurant.name!)
                }
                state = sort(state.restaurants, state.currentSortingFilter)
                state.changelog = [.loadingState, .restaurants(.reload)]
            case .saveSortFilter(let filter):
                state.currentSortingFilter = filter
                state = sort(state.restaurants, filter)
                state.changelog = [.loadingState, .restaurants(.reload)]
            case .reloadFilters(let newFilters):
                state.sortingFilters = newFilters
            case .addActivity:
                state.loadingState.addActivity()
                state.changelog = [.loadingState]
            case .removeActivity:
                state.loadingState.removeActivity()
                state.changelog = [.loadingState]
            case .reloadRestaurants(let newRestaurants):
                state = sort(newRestaurants, nil)
                state.changelog = [.restaurants(.reload)]
            case .addRestaurant(let Restaurant):
                state.restaurants.insert(Restaurant, at: 0)
                state.changelog = [.restaurants(.insertion(0))]
            case .removeRestaurant(index: let index):
                guard index >= 0 && index < state.restaurants.count else { return }
                state.restaurants.remove(at: index)
                state.changelog = [.restaurants(.deletion(index))]
            case .error(let error):
                state.error = error
                state.changelog = [.error]
            }
            
            commit(state)
        }
    }
    
    func sort(_ restaurants: [Restaurant], _ filter: String?) -> RestaurantListState {
        var state = self.state
        state.restaurants = RestaurantSorting.sorting(withKey: filter, restaurants: restaurants)
        
        return state
    }
    
    func fetchCommand() -> RestaurantListFetchCommand {
        return RestaurantListFetchCommand(service: service)
    }
}

// MARK: - Commands

class RestaurantListFetchCommand: Command {
    
    let service: RestaurantsService
    
    init(service: RestaurantsService) {
        self.service = service
    }
    
    func execute(on component: Component<RestaurantListState>, core: Core) {
        core.dispatch(RestaurantListAction.addActivity)
        
        service.fetchRestaurants { (result) in
            core.dispatch(RestaurantListAction.removeActivity)
            switch result {
            case .success(let restaurants):
                core.dispatch(RestaurantListAction.reloadRestaurants(restaurants))
            case .failure(let error):
                core.dispatch(RestaurantListAction.error(error))
            }
        }
        
        service.fetchSortingKeys { (result) in
            switch result {
            case .success(let keys):
                core.dispatch(RestaurantListAction.reloadFilters(keys))
            case .failure(let error):
                core.dispatch(RestaurantListAction.error(error))
            }
        }
    }
}

// MARK: - Helpers

extension RestaurantListState.Change: Equatable {
    
    static func ==(lhs: RestaurantListState.Change, rhs: RestaurantListState.Change) -> Bool {
        
        switch (lhs, rhs) {
        case (.restaurants(let update1), .restaurants(let update2)):
            return update1 == update2
        case (.loadingState, .loadingState):
            return true
        default:
            return false
        }
    }
}
