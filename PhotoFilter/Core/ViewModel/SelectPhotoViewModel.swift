//
//  SelectPhotoViewModel.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 26.03.2024.
//

import Foundation
protocol SelectPhotoViewModelInterface {
    var view: SelectPhotoViewInterface? { get set }
    func viewDidLoad()
}

final class SelectPhotoViewModel {
    weak var view: SelectPhotoViewInterface?
    
}

extension SelectPhotoViewModel: SelectPhotoViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureTabView()
        view?.configureDefaultSelectView()
        view?.configureSelectPhotoButton()
    }
}
