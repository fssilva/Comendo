//
//  NavigationPerformer+Restaurant.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import UIKit
import CoreArchitecture

extension NavigationPerformer where Self: UIViewController {
    
    func perform(_ navigation: Navigation) {
        guard let navigation = navigation as? BasicNavigation else { return }
        switch navigation {
        case .push(let component, from: _):
            guard let vc = viewController(for: component) else { return }
            navigationController?.pushViewController(vc, animated: true)
        case .pop(_):
            // TODO: Validate vc's component.
            navigationController?.popViewController(animated: true)
        case .present(let component, from: _):
            guard let vc = viewController(for: component) else { return }
            let nc = UINavigationController(rootViewController: vc)
            present(nc, animated: true, completion: nil)
        case .dismiss(_):
            // TODO: Validate vc's component.
            presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func viewController(for component: AnyComponent) -> UIViewController? {
        let vc: UIViewController?
        if let component = component as? RestaurantListComponent {
            vc = RestaurantListViewController.instantiate(with: component)
        } else if let component = component as? RestaurantDetailsComponent {
            vc = RestaurantDetailsViewController.instantiate(with: component)
        } else {
            vc = nil
        }
        return vc
    }
}

