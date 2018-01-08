//
//  RestaurantListViewController.swift
//  Comendo
//
//  Created by Felipe de Sousa Silva on 08.01.18.
//  Copyright (c) 2018 Netlight. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RestaurantListViewController: UIViewController {
    fileprivate let viewModel: RestaurantListViewModel
    fileprivate let router: RestaurantListRouter
    fileprivate let disposeBag = DisposeBag()

    init(withViewModel viewModel: RestaurantListViewModel, router: RestaurantListRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()
        setupRx()
    }
}

// MARK: Setup
private extension RestaurantListViewController {

    func setupViews() {
        
    }

    func setupLayout() {
    
    }

    func setupRx() {
    
    }
}
