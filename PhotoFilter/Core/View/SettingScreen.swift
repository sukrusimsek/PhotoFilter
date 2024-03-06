//
//  SettingScreen.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 6.03.2024.
//

import UIKit
protocol SettingScreenInterface: AnyObject {
    func configureVC()
}

final class SettingScreen: UIViewController {
    private let viewModel = SettingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    
}

extension SettingScreen: SettingScreenInterface {
    func configureVC() {
        view.backgroundColor = .systemBlue
    }
    
}
