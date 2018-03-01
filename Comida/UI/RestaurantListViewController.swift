//
//  RestaurantListViewController.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import UIKit
import CoreArchitecture
import ActionSheetPicker_3_0

final class RestaurantListViewController: BaseTableViewController {
    
    private struct Const {
        static let cellReuseID = "Cell"
    }
    
    var isFirstRun = true
    
    var component: RestaurantListComponent!
    var presentation: RestaurantListPresentation = RestaurantListPresentation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Restaurants"
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
    
    
    // MARK: Actions
    
    @IBAction func filterButtonTap(_ sender: UIBarButtonItem) {
        var initialIndex = 0
        if let currentFilter = component.state.currentSortingFilter {
            for i in 0..<presentation.sortingFilters.count {
                if presentation.sortingFilters[i].name == currentFilter {
                    initialIndex = i
                    break
                }
            }
        }
        
        ActionSheetStringPicker.show(withTitle: "Filters", rows: presentation.sortingFilters, initialSelection: initialIndex, doneBlock: {picker, indexes, values in
            let filter = self.component.state.sortingFilters[indexes]
            core.dispatch(RestaurantListAction.saveSortFilter(filter))
        }, cancel: {_ in }, origin: self.view)
    }
    
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentation.restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rest = self.component.state.restaurants[indexPath.row]
        var action: UITableViewRowAction
        if !rest.isFavorite {
            action = UITableViewRowAction(style: .normal, title: "Favorite") { (rowAction, indexPath) in
                let rest = self.component.state.restaurants[indexPath.row]
                core.dispatch(RestaurantListAction.favoriteRestaurant(rest, true))
            }
            action.backgroundColor = .green
        }else {
            action = UITableViewRowAction(style: .normal, title: "Unfavorite") { (rowAction, indexPath) in
                let rest = self.component.state.restaurants[indexPath.row]
                core.dispatch(RestaurantListAction.favoriteRestaurant(rest, false))
            }
            action.backgroundColor = .red
        }
        
        return [action]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        core.dispatch(RestaurantListAction.removeRestaurant(index: indexPath.row))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var templateCell = tableView.dequeueReusableCell(withIdentifier: Const.cellReuseID)
        if templateCell == nil {
            templateCell = UITableViewCell(style: .subtitle, reuseIdentifier: Const.cellReuseID)
        }
        guard let cell = templateCell else {
            fatalError()
        }
        let RestaurantPresentation = presentation.restaurants[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = RestaurantPresentation.name
        cell.detailTextLabel?.text = RestaurantPresentation.status
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let restaurants = component.state.restaurants
        let index = indexPath.row
        if index < restaurants.count {
            core.dispatch(RestaurantListNavigatorAction.detail(restaurants[index]))
        }
    }
}

extension RestaurantListViewController {
    
    static func instantiate(with component: RestaurantListComponent) -> RestaurantListViewController {
        let sb = Storyboard.main
        let id = String(describing: self)
        let vc = sb.instantiateViewController(withIdentifier: id) as! RestaurantListViewController
        vc.component = component
        return vc
    }
}

// MARK: - Updates

struct RestaurantListPresentation {
    
    var restaurants: [RestaurantPresentation] = []
    var sortingFilters: [FilterPresentation] = []
    
    mutating func update(with state: RestaurantListState) {
        restaurants = state.restaurants.map { RestaurantPresentation(restaurant: $0) }
    }
    
    mutating func updateFilter(with state: RestaurantListState) {
        sortingFilters = state.sortingFilters.map {FilterPresentation(filter: $0)}
    }
}

extension RestaurantListViewController: Subscriber {
    
    func update(with state: RestaurantListState) {
        presentation.update(with: state)
        presentation.updateFilter(with: state)
        state.changelog.forEach { handle(state: state, change: $0) }
    }
    
    private func handle(state: RestaurantListState, change: RestaurantListState.Change) {
        switch change {
        case .loadingState:
            if state.loadingState.needsUpdate {
                setLoading(state.loadingState.isActive)
            }
        case .restaurants(let collectionChange):
            tableView.applyCollectionChange(collectionChange, toSection: 0, withAnimation: .automatic)
        case .error:
            guard let error = state.error else { return }
            handle(error: error)
        }
    }
    
    private func setLoading(_ isLoading: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
    }
}

