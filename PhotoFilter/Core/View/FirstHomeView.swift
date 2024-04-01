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
    private var collectionView: UICollectionView!
    private var timer: Timer?
    private var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}


extension FirstHomeView: FirstHomeViewInterface, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func configureVC() {
        print("configureVCFirstHomeView")
//        startTimer()
        
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FirstHomeCell.self, forCellWithReuseIdentifier: "FirstHomeCell")
        collectionView.isPagingEnabled = true
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstHomeCell", for: indexPath) as! FirstHomeCell
        cell.buttonForSelectPhoto.addTarget(self, action: #selector(tappedChoosePhotosForFilter), for: .touchUpInside)
        switch indexPath.row {
        case 0:
            cell.imageForFilter.image = UIImage(named: "fuji")
            cell.blurLabelForFilterName.text = "FILTER - MEDIAN"
            cell.labelForDesc.text = "Fuji mountain lake in Morning"
            cell.labelForButton.textColor = .systemBlue
            cell.imageForButton.tintColor = .systemBlue
            cell.imageForFilter.applyGradient(colors: [.black, .clear], locations: [0.0, 0.5])
            cell.applyGradient(colors: [.black, .clear], locations: [0, 3])

        case 1:
            cell.imageForFilter.image = UIImage(named: "african")
            cell.blurLabelForFilterName.text = "FILTER - ENERGIC"
            cell.labelForDesc.text = "African American Woman"
            cell.labelForButton.textColor = .systemYellow
            cell.imageForButton.tintColor = .systemYellow
            cell.imageForFilter.applyGradient(colors: [.black, .clear], locations: [0.0, 0.5])
            cell.applyGradient(colors: [.black, .clear], locations: [0, 3])

        case 2:
            cell.imageForFilter.image = UIImage(named: "handcream")
            cell.blurLabelForFilterName.text = "FILTER - BEATIFUL"
            cell.labelForDesc.text = "Hand cream product package"
            cell.labelForButton.textColor = .systemGreen
            cell.imageForButton.tintColor = .systemGreen
            

            
            
        default:
            break
        }
        return cell
    }
    @objc func tappedChoosePhotosForFilter() {
        print("tappedChoosePhotosForFilter")
        navigationController?.pushViewController(SelectPhotoView(), animated: true)
    }
//    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        // Kullanıcı koleksiyonu elle kaydırdığında, otomatik geçişleri durdurun
//        timer?.invalidate()
//        timer = nil
//    }
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        // Kullanıcı elle kaydırma işlemi bittiğinde, otomatik geçişleri yeniden başlatın
//        startTimer()
//    }
//    
//    
//    
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
//    }
//    @objc func scrollToNextPage() {
//        currentPage = (currentPage + 1) % collectionView.numberOfItems(inSection: 0)
//        let indexPath = IndexPath(item: currentPage, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//    }
//    
}
