//
//  HomeViewModel.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 25.02.2024.
//

import Foundation
protocol HomeViewModelInterface {
    var view: HomeScreenInterface? { get set }
    func viewDidLoad()
}
final class HomeViewModel {
    weak var view: HomeScreenInterface?
}

extension HomeViewModel: HomeViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
    }
}
