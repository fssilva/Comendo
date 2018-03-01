//
//  BaseViewController.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import UIKit
import CoreArchitecture

class BaseViewController: UIViewController, NavigationPerformer, ErrorHandler {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let viewControllers = navigationController?.viewControllers, viewControllers.index(of: self) == nil {
            backButtonTapped()
        }
    }
    
    func backButtonTapped() { }
}

class BaseTableViewController: UITableViewController, NavigationPerformer, ErrorHandler {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let viewControllers = navigationController?.viewControllers, viewControllers.index(of: self) == nil {
            backButtonTapped()
        }
    }
    
    func backButtonTapped() { }
}

class BaseCollectionViewController: UITableViewController, NavigationPerformer, ErrorHandler {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let viewControllers = navigationController?.viewControllers, viewControllers.index(of: self) == nil {
            backButtonTapped()
        }
    }
    
    func backButtonTapped() { }
}

