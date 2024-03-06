//
//  SettingViewModel.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 6.03.2024.
//

import Foundation
protocol SettingViewModelInterface {
    var view: SettingScreenInterface? { get set }
    func viewDidLoad()
}
final class SettingViewModel {
    weak var view: SettingScreenInterface?
}


extension SettingViewModel: SettingViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureTableView()
    }
}
