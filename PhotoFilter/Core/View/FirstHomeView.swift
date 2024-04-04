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
    private let color1 = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
    private let color2 = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
    private let color3 = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.1)
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }

}


extension FirstHomeView: FirstHomeViewInterface, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func configureVC() {
        print("configureVCFirstHomeView")

        
    }
    
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FirstHomeCell.self, forCellWithReuseIdentifier: "FirstHomeCell")
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 150, bottom: 200, right: 150)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.indicatorStyle = .white
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let firstCell = cell as? FirstHomeCell {
            firstCell.animateIn()
            
        }
        if indexPath.item == 2 {
            print("Son hücreye ulaşıldı.")
        }

        if let lastCell = collectionView.visibleCells.last, let lastCellIndexPath = collectionView.indexPath(for: lastCell), indexPath == lastCellIndexPath {
            if let firstCell = cell as? FirstHomeCell {
                firstCell.animateOut()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstHomeCell", for: indexPath) as! FirstHomeCell
        cell.buttonForSelectPhoto.addTarget(self, action: #selector(tappedChoosePhotosForFilter), for: .touchUpInside)
        
        cell.applyGradient(colors: [color1, color2, color3] ,startPoint: CGPoint(x: 0.5, y: 1.0), endPoint: CGPoint(x: 0.5, y: 0.0), locations: [0.35,0.70,0.95])
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            collectionView.reloadData()
//        }
        
        switch indexPath.row {
        case 0:
            cell.imageForFilter.image = UIImage(named: "123")
            cell.blurLabelForFilterName.text = "FILTER - MEDIAN"
            cell.labelForDesc.text = "Fuji mountain lake in Morning"
            cell.labelForButton.textColor = .systemBlue
            cell.imageForButton.tintColor = .systemBlue
            
        case 1:
            cell.imageForFilter.image = UIImage(named: "african")
            cell.blurLabelForFilterName.text = "FILTER - ENERGIC"
            cell.labelForDesc.text = "African American Woman"
            cell.labelForButton.textColor = .systemYellow
            cell.imageForButton.tintColor = .systemYellow

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
    
}
