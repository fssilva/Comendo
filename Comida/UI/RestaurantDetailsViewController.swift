//
//  RestaurantDetailsViewController.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 10.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import UIKit
import CoreArchitecture

class RestaurantDetailsViewController: BaseViewController {
   
    var isFirstRun = true
    
    var component: RestaurantDetailsComponent!
    var presentation: RestaurantDetailsPresentation = RestaurantDetailsPresentation()
    
    @IBOutlet weak var restaurantStatus: UILabel!
    @IBOutlet weak var sortingKeyLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        component.subscribe(self)
        if isFirstRun {
            isFirstRun = false
            core.dispatch(component.fetchCommand())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if zap_isBeingRemoved {
            component.unsubscribe(self)
        }
    }
}

extension RestaurantDetailsViewController {
    
    static func instantiate(with component: RestaurantDetailsComponent) -> RestaurantDetailsViewController {
        let sb = Storyboard.main
        let id = String(describing: self)
        let vc = sb.instantiateViewController(withIdentifier: id) as! RestaurantDetailsViewController
        vc.component = component
        return vc
    }
}

struct RestaurantDetailsPresentation {
    
    var restaurant: RestaurantPresentation!
    
    mutating func update(with state: RestaurantDetailsState) {
        if let rest = state.restaurant {
            restaurant = RestaurantPresentation(restaurant: rest)
        }
    }
}

extension RestaurantDetailsViewController: Subscriber {
    
    func update(with state: RestaurantDetailsState) {
        presentation.update(with: state)
        state.changelog.forEach { handle(state: state, change: $0) }
    }
    
    private func handle(state: RestaurantDetailsState, change: RestaurantDetailsState.Change) {
        switch change {
        case .loadingState:
            if state.loadingState.needsUpdate {
                setLoading(state.loadingState.isActive)
            }
        case .updateDisplay:
            update(presentation.restaurant)
        case .error:
            guard let error = state.error else { return }
            handle(error: error)
        }
    }
    
    private func update(_ restaurant: RestaurantPresentation) {
        title = restaurant.name
        restaurantStatus.text = restaurant.status
        sortingKeyLabel.text = restaurant.sortingValues.description
        favoriteLabel.text = restaurant.isFavorite.description
    }
    
    private func setLoading(_ isLoading: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
    }
}
