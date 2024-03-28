//
//  FirstHomeView.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 28.03.2024.
//

import UIKit

protocol FirstHomeViewInterface: AnyObject {
    func configureVC()
    func configureCollectionView()
}

final class FirstHomeView: UIViewController {

    private let viewModel = FirstHomeViewModel()
    private var collectionView = UICollectionView()
    private var timer: Timer?
    private var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}


extension FirstHomeView: FirstHomeViewInterface, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // Kullanıcı koleksiyonu elle kaydırdığında, otomatik geçişleri durdurun
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Kullanıcı elle kaydırma işlemi bittiğinde, otomatik geçişleri yeniden başlatın
        startTimer()
    }
    
    
    func configureVC() {
        print("configureVCFirstHomeView")
        startTimer()
        
        
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    @objc func scrollToNextPage() {
        currentPage = (currentPage + 1) % collectionView.numberOfItems(inSection: 0)
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        
    }
}
