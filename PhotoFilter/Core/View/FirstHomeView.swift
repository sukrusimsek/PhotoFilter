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
    func configureLabel()
    func configureLocalizationButton()
    func configureFilterPhotosButton()
}

final class FirstHomeView: UIViewController {

    private let viewModel = FirstHomeViewModel()
    private var collectionView: UICollectionView!
    private var timer: Timer?
    private var currentPage = 0
    private let color1 = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
    private let color2 = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
    private let color3 = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.1)
    
    private var labelDeneme = UILabel()
    private let locationButton = UIButton()
    private let button = UIButton()
    private let labelForButton = UILabel()
    private let viewBack = UIView()
    private let imageViewForIcon = UIImageView()

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
    func configureLabel() {
        
        labelDeneme.text = "Fuji mountain lake in Morning"
        labelDeneme.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        labelDeneme.textColor = UIColor(white: 1, alpha: 0.5)
        labelDeneme.textAlignment = .center
        labelDeneme.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelDeneme)
        
        NSLayoutConstraint.activate([
            labelDeneme.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelDeneme.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            label.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    func configureLocalizationButton() {
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setTitle("   EN   ", for: .normal)
        locationButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        locationButton.layer.cornerRadius = 9
        locationButton.layer.masksToBounds = true
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isUserInteractionEnabled = false
        blurView.frame = locationButton.bounds
        blurView.translatesAutoresizingMaskIntoConstraints = false
        locationButton.insertSubview(blurView, at: 0)
        blurView.leadingAnchor.constraint(equalTo: locationButton.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: locationButton.trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: locationButton.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: locationButton.bottomAnchor).isActive = true
        view.addSubview(locationButton)
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
        ])
        locationButton.addTarget(self, action: #selector(tappedLocalizationButton), for: .touchUpInside)
        
    }
    
    
    @objc func tappedLocalizationButton() {
        print("tappedLocalizationButton")
    }
    func configureFilterPhotosButton() {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 1, alpha: 0.2)
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        view.addSubview(button)
        labelForButton.translatesAutoresizingMaskIntoConstraints = false
        labelForButton.font = .systemFont(ofSize: 16, weight: .semibold)
        labelForButton.text = "   Filter Your Photos"
        labelForButton.numberOfLines = 1
        labelForButton.textAlignment = .left
        button.addSubview(labelForButton)
        viewBack.translatesAutoresizingMaskIntoConstraints = false
        viewBack.backgroundColor = UIColor(white: 1, alpha: 0.3)
        viewBack.layer.cornerRadius = 16
        viewBack.layer.masksToBounds = true
        button.addSubview(viewBack)
        imageViewForIcon.translatesAutoresizingMaskIntoConstraints = false
        imageViewForIcon.image = UIImage(named: "cellSelectButton")
        button.addSubview(imageViewForIcon)
        button.addTarget(self, action: #selector(tappedChoosePhotosForFilter), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 56),
            button.widthAnchor.constraint(equalToConstant: 212),
            
            
            labelForButton.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 5),
            labelForButton.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            viewBack.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            viewBack.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            viewBack.heightAnchor.constraint(equalToConstant: 34),
            viewBack.widthAnchor.constraint(equalToConstant: 34),
            
            imageViewForIcon.centerXAnchor.constraint(equalTo: viewBack.centerXAnchor),
            imageViewForIcon.centerYAnchor.constraint(equalTo: viewBack.centerYAnchor),
            imageViewForIcon.heightAnchor.constraint(equalToConstant: 14),
            imageViewForIcon.widthAnchor.constraint(equalToConstant: 21),
        ])
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let initialX = scrollView.contentOffset.x + scrollView.frame.width
        let targetX = scrollView.contentOffset.x + scrollView.frame.width / 2
        labelDeneme.alpha = max(0, min(1, (initialX - targetX) / scrollView.frame.width))
        labelDeneme.transform = CGAffineTransform(translationX: 0, y: scrollView.contentOffset.y)
        
        labelDeneme.alpha = 0.0
        labelDeneme.frame.origin.y = view.frame.height - 350
        
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        UIView.animate(withDuration: 1.8) {
            self.labelDeneme.frame.origin.y = self.view.frame.height * 0.45
//            self.blurLabelForFilterName.frame.origin.y = self.blurView.frame.midY - (self.blurView.frame.height / 4.5)
//            self.labelForDesc.frame.origin.y = self.blurView.frame.maxY + 10
        }
        
        UIView.animate(withDuration: 1.8, delay: 0.4, options: [.curveEaseOut], animations: {
//            self.blurLabelForFilterName.alpha = 1.0
//            self.blurView.alpha = 1.0
            self.labelDeneme.alpha = 1.0
        }, completion: nil)
        
        
        switch pageIndex {
        case 0:
            labelDeneme.text = "Fuji mountain lake in Morning"
        case 1:
            labelDeneme.text = "African American Woman"
        case 2:
            labelDeneme.text = "Hand cream product package"
        default:
            break
        }
        
        let locationButtonInitialX = scrollView.contentOffset.x + scrollView.frame.width
        let locationButtonTargetX = scrollView.contentOffset.x + scrollView.frame.width / 2
        locationButton.alpha = max(0, min(1, (locationButtonInitialX - locationButtonTargetX) / scrollView.frame.width))
        locationButton.transform = CGAffineTransform(translationX: 0, y: scrollView.contentOffset.y)
        
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

//        if let lastCell = collectionView.visibleCells.last, let lastCellIndexPath = collectionView.indexPath(for: lastCell), indexPath == lastCellIndexPath {
//            if let firstCell = cell as? FirstHomeCell {
//                firstCell.animateOut()
//            }
//        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstHomeCell", for: indexPath) as! FirstHomeCell
        
        cell.applyGradient(colors: [color1, color2, color3] ,startPoint: CGPoint(x: 0.5, y: 1.0), endPoint: CGPoint(x: 0.5, y: 0.0), locations: [0.35,0.70,0.95])
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            collectionView.reloadData()
//        }
        
        switch indexPath.row {
        case 0:
            cell.imageForFilter.image = UIImage(named: "fuji")
            cell.blurLabelForFilterName.text = "FILTER - MEDIAN"
            cell.labelForDesc.text = "Fuji mountain lake in Morning"
            labelForButton.textColor = .systemBlue
            imageViewForIcon.tintColor = .systemBlue
            
        case 1:
            cell.imageForFilter.image = UIImage(named: "african")
            cell.blurLabelForFilterName.text = "FILTER - ENERGIC"
            cell.labelForDesc.text = "African American Woman"
            labelForButton.textColor = .systemYellow
            imageViewForIcon.tintColor = .systemYellow

        case 2:
            cell.imageForFilter.image = UIImage(named: "handcream")
            cell.blurLabelForFilterName.text = "FILTER - BEATIFUL"
            cell.labelForDesc.text = "Hand cream product package"
            labelForButton.textColor = .systemGreen
            imageViewForIcon.tintColor = .systemGreen
            
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

