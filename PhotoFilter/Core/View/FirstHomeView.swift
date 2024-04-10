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
    func configureLabelsForScrolling()
}

final class FirstHomeView: UIViewController {

    private let viewModel = FirstHomeViewModel()
    private var collectionView: UICollectionView!
    private var timer: Timer?
    private var currentPage = 0
    private let color1 = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
    private let color2 = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
    private let color3 = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.1)
    
    private var labelDesc = UILabel()
    private let locationButton = UIButton()
    private let button = UIButton()
    private let labelForButton = UILabel()
    private let viewBack = UIView()
    private let imageViewForIcon = UIImageView()
    private let blurLabel = UILabel()
    private let blurViewForLabel: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 16
        blurView.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        blurView.layer.borderWidth = 1
        blurView.layer.masksToBounds = true
        return blurView
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        

    }
    

}


extension FirstHomeView: FirstHomeViewInterface, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func configureVC() {
        print("configureVCFirstHomeView")

        
    }
    
    func configureLocalizationButton() {
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setTitle("EN", for: .normal)
        locationButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        locationButton.setTitleColor(.white, for: .normal)
        locationButton.layer.cornerRadius = 9
        locationButton.layer.masksToBounds = true
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isUserInteractionEnabled = false
        blurView.frame = locationButton.bounds
        blurView.translatesAutoresizingMaskIntoConstraints = false
        locationButton.insertSubview(blurView, at: 0)
        blurView.leadingAnchor.constraint(equalTo: locationButton.leadingAnchor,constant: -32).isActive = true
        blurView.trailingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: 32).isActive = true
        blurView.topAnchor.constraint(equalTo: locationButton.topAnchor, constant: -18).isActive = true
        blurView.bottomAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 18).isActive = true
        view.addSubview(locationButton)
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
        ])
        locationButton.addTarget(self, action: #selector(tappedLocalizationButton), for: .touchUpInside)
        
    }
    
    
    @objc func tappedLocalizationButton() {
        print("tappedLocalizationButton")
        if locationButton.titleLabel?.text == "EN" {
            locationButton.setTitle("TR", for: .normal)
        } else {
            locationButton.setTitle("EN", for: .normal)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.locationButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.locationButton.alpha = 0.7
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.locationButton.transform = .identity
                self.locationButton.alpha = 1.0
            }
        }
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
        imageViewForIcon.image = UIImage(named: "cellSelectButton2")
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
    func configureLabel() {
        labelDesc.text = "Fuji mountain lake in Morning"
        labelDesc.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        labelDesc.textColor = UIColor(white: 1, alpha: 1)
        labelDesc.textAlignment = .center
        labelDesc.numberOfLines = 2
        labelDesc.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelDesc)
        
        NSLayoutConstraint.activate([
            labelDesc.topAnchor.constraint(equalTo: blurViewForLabel.bottomAnchor, constant: 10),
            labelDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            labelDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

        ])
        
    }
    func configureLabelsForScrolling() {
        blurLabel.translatesAutoresizingMaskIntoConstraints = false
        blurLabel.font = .systemFont(ofSize: 12, weight: .regular)
        blurLabel.textColor = .white
        blurLabel.text = "FILTER - MEDIAN"
        blurLabel.layer.cornerRadius = 5
        blurLabel.layer.masksToBounds = true
        view.addSubview(blurLabel)
        
//        blurLabel.insertSubview(blurViewForLabel, at: 0)
        view.addSubview(blurViewForLabel)
        blurLabel.layer.zPosition = 1

        NSLayoutConstraint.activate([
            blurLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            blurViewForLabel.topAnchor.constraint(equalTo: blurLabel.topAnchor, constant: -10),
            blurViewForLabel.leadingAnchor.constraint(equalTo: blurLabel.leadingAnchor, constant: -10),
            blurViewForLabel.trailingAnchor.constraint(equalTo: blurLabel.trailingAnchor, constant: 10),
            blurViewForLabel.bottomAnchor.constraint(equalTo: blurLabel.bottomAnchor, constant: 10),

        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        blurLabel.alpha = 0.0
        blurViewForLabel.alpha = 0.0
        labelDesc.alpha = 0.0
        
        labelDesc.frame.origin.y = view.frame.height - 200
        blurViewForLabel.frame.origin.y = view.frame.height - 200
        blurLabel.frame.origin.y = view.frame.height - 200
        
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        UIView.animate(withDuration: 0.8) {
            self.blurViewForLabel.frame.origin.y = (self.view.frame.height * 0.5) + 30
            self.blurLabel.frame.origin.y = self.blurViewForLabel.frame.midY - (self.blurViewForLabel.frame.height / 4.5)
            self.labelDesc.frame.origin.y = self.blurViewForLabel.frame.origin.y + 50
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.5, options: [.curveEaseOut], animations: {
            self.blurLabel.alpha = 1.0
            self.blurViewForLabel.alpha = 1.0
            self.labelDesc.alpha = 1.0
        }, completion: nil)
        
        
        switch pageIndex {
        case 0:
            labelDesc.text = "Fuji mountain lake in Morning"
            blurLabel.text = "FILTER - MEDIAN"
        case 1:
            labelDesc.text = "African American Woman"
            blurLabel.text = "FILTER - BEATIFUL"
        case 2:
            labelDesc.text = "Hand cream product package"
            blurLabel.text = "FILTER - ENERGIC"
        default:
            break
        }

        let locationButtonInitialX = scrollView.contentOffset.x + scrollView.frame.width
        let locationButtonTargetX = scrollView.contentOffset.x + scrollView.frame.width / 2
        locationButton.alpha = max(0, min(1, (locationButtonInitialX - locationButtonTargetX) / scrollView.frame.width))
        locationButton.transform = CGAffineTransform(translationX: 0, y: scrollView.contentOffset.y)
        
//        let pageIndex2 = Int(scrollView.contentOffset.x / scrollView.bounds.width)
//        
//        // Eğer pageIndex 2'ye eşitse ve sola doğru kaydırma yapıldıysa
//        if pageIndex2 == 2 && scrollView.panGestureRecognizer.translation(in: scrollView.superview).x < 0 {
//            // Başka bir sayfaya yönlendirme işlemini gerçekleştir
//            print("2. index'e ulaşıldı ve sola doğru kaydırma yapıldı.")
//            navigationController?.pushViewController(SelectPhotoView(), animated: true)
//        }
        
        
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
    
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.x
//        let contentHeight = scrollView.contentSize.width
//        let width = scrollView.frame.size.width
//
//        if offsetY >= contentHeight - 10 {
//            print("asdklhfglka")
//        }
//        
//    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                labelForButton.textColor = UIColor.systemBlue
                imageViewForIcon.image = UIImage(named: "cellSelectButtonBlue")
            case 1:
                labelForButton.textColor = UIColor.systemYellow
                imageViewForIcon.image = UIImage(named: "cellSelectButtonYellow")
            case 2:
                labelForButton.textColor = UIColor.systemGreen
                imageViewForIcon.image = UIImage(named: "cellSelectButtonGreen")
            default:
                break
            }
        
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

        case 1:
            cell.imageForFilter.image = UIImage(named: "african")

        case 2:
            cell.imageForFilter.image = UIImage(named: "handcream")
        default:
            break
        }
        return cell
        
    }
    @objc func tappedChoosePhotosForFilter() {
        print("tappedChoosePhotosForFilter")
        navigationController?.pushViewController(SelectPhotoView(), animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
       
    }
    
}

