//
//  FirstHomeViewModel.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 28.03.2024.
//

import Foundation

protocol FirstHomeViewModelInterface {
    var view: FirstHomeViewInterface? { get set }
    func viewDidLoad()
}

final class FirstHomeViewModel {
    weak var view: FirstHomeViewInterface?
    
    
}

extension FirstHomeViewModel: FirstHomeViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
        view?.configureLabelsForScrolling()
        view?.configureLabel()
        view?.configureLocalizationButton()
        view?.configureFilterPhotosButton()
    }
}
