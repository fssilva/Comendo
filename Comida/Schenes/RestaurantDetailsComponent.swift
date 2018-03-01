//
//  RestaurantDetailsComponent.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 10.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation
import CoreArchitecture

// MARK: - State

struct RestaurantDetailsState: State {
    
    enum Change {
        case loadingState
        case updateDisplay
        case error
    }
    
    var loadingState = ActivityTracker()
    var restaurant: Restaurant?
    var sortingFilters: [String] = []
    var error: Error? = nil
    var changelog: [Change] = [.loadingState, .error]
}

// MARK: - Actions

enum RestaurantDetailsAction: Action {
    case addActivity
    case removeActivity
    case error(Error)
}

enum RestaurantDetailsNavigatorAction: Action {
    case map(Restaurant)
}

// MARK: - Component

class RestaurantDetailsComponent: Component<RestaurantDetailsState> {
    
    let navigator: Navigator
    let restaurant: Restaurant
    
    init(restaurant: Restaurant, navigator: Navigator) {
        self.navigator = navigator
        self.restaurant = restaurant
        super.init(state: RestaurantDetailsState())
    }
    
    override func process(_ action: Action) {
        if let navigation = navigator.resolve(action) {
            commit(navigation)
        } else {
            guard let action = action as? RestaurantDetailsAction else { return }
            var state = self.state
            state.changelog = []
            
            switch action {
            case .addActivity:
                state.restaurant = restaurant
                state.loadingState.addActivity()
                state.changelog = [.updateDisplay]
            case .removeActivity:
                state.loadingState.removeActivity()
                state.changelog = [.loadingState]
            case .error(let error):
                state.error = error
                state.changelog = [.error]
            }
            
            commit(state)
        }
    }
    
    func fetchCommand() -> RestaurantDetailsFetchCommand {
        return RestaurantDetailsFetchCommand()
    }
}

// MARK: - Commands

class RestaurantDetailsFetchCommand: Command {
    
    func execute(on component: Component<RestaurantDetailsState>, core: Core) {
        core.dispatch(RestaurantDetailsAction.addActivity)
    }
}
