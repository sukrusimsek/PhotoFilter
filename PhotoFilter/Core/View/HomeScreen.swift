//
//  ViewController.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 25.02.2024.
//

import UIKit
protocol HomeScreenInterface: AnyObject {
    func configureVC()
}
final class HomeScreen: UIViewController {
    private let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}

extension HomeScreen: HomeScreenInterface {
    func configureVC() {
        view.backgroundColor = .brown
    }
}
