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
    func applyFiltersOnCollectionView()
}
final class HomeViewModel {
    weak var view: HomeScreenInterface?
    
}

extension HomeViewModel: HomeViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureOutputView()
        view?.configureImagePickerButton()
        
        view?.configureCollectionView()
        view?.createDivider()
//        view?.configureShareButton()
        view?.configureSaveButton()
        view?.configureShowOriginalButton()
//        view?.configureBackgroundRemoverButton()
        view?.viewForCollectionViewAndSelectShow()
    }
    func applyFiltersOnCollectionView() {
        //We will change our filter funcs. They will be here. Because we're using MVVM Design Pattern.
    }
    
}
