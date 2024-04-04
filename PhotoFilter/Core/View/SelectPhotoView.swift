//
//  SelectPhotoView.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 26.03.2024.
//

import UIKit
protocol SelectPhotoViewInterface: AnyObject {
    func configureVC()
    func configureTabView()
    func configureDefaultSelectView()
    func configureSelectPhotoButton()
    
    
}

final class SelectPhotoView: UIViewController {
    private let viewModel = SelectPhotoViewModel()
    private let tabView = UIView()
    private let defaultViewButton = UIImageView()
    private let selectPhoto = UIButton()
    let homeIndicator = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}
extension SelectPhotoView: SelectPhotoViewInterface {
    func configureVC() {
        
        view.backgroundColor = UIColor(rgb: 0x191919)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(rgb: 0x101010)
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(goToSettingScreenTapped), imageName: "settingsButton")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(tappedBackPage), imageName: "backButton", height: 32, width: 32)
        
        
    }
    @objc private func tappedBackPage() {
        print("tappedBackPage")
//        navigationController?.dismiss(animated: true)
    }
    @objc private func goToSettingScreenTapped() {
        print("goToSettingScreenTapped")
        navigationController?.pushViewController(SettingScreen(), animated: true)
        
    }
    func configureTabView() {
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.backgroundColor = UIColor(rgb: 0x101010)
        
        homeIndicator.translatesAutoresizingMaskIntoConstraints = false
        homeIndicator.backgroundColor = UIColor(white: 1, alpha: 0.2)
        homeIndicator.layer.cornerRadius = 1
        homeIndicator.layer.masksToBounds = true
        view.addSubview(tabView)
        tabView.addSubview(homeIndicator)
        
        NSLayoutConstraint.activate([
            tabView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075),
            tabView.widthAnchor.constraint(equalToConstant: view.frame.width),
            tabView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            homeIndicator.topAnchor.constraint(equalTo: tabView.topAnchor, constant: 10),
            homeIndicator.widthAnchor.constraint(equalToConstant: 40),
            homeIndicator.centerXAnchor.constraint(equalTo: tabView.centerXAnchor),
            homeIndicator.heightAnchor.constraint(equalToConstant: 3),
            
        ])
    }
    func configureDefaultSelectView() {
        defaultViewButton.translatesAutoresizingMaskIntoConstraints = false
        defaultViewButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        defaultViewButton.image = UIImage(named: "defaultImage2")
        view.addSubview(defaultViewButton)
        
        NSLayoutConstraint.activate([
            defaultViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            defaultViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            defaultViewButton.widthAnchor.constraint(equalToConstant: 80),
            defaultViewButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
    }
    func configureSelectPhotoButton() {
        selectPhoto.translatesAutoresizingMaskIntoConstraints = false
        selectPhoto.setTitle("  Select Photo +  ", for: .normal)
        selectPhoto.setTitleColor(.white, for: .normal)
        selectPhoto.backgroundColor = UIColor(white: 1, alpha: 0.2)
        selectPhoto.layer.cornerRadius = 15
        selectPhoto.layer.masksToBounds = true
        selectPhoto.addTarget(self, action: #selector(tappedSelectPhotoPage), for: .touchUpInside)
        view.addSubview(selectPhoto)
        
        NSLayoutConstraint.activate([
            selectPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectPhoto.topAnchor.constraint(equalTo: defaultViewButton.bottomAnchor, constant: 10)
        ])
    }
    @objc func tappedSelectPhotoPage() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            NotificationCenter.default.post(name: NSNotification.Name("PickerViewOn"), object: nil)
        }
        
       
        let loginViewController = HomeScreen()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
        print("Geçiş Başarılı...")
        
        
        
        
//        navigationController?.pushViewController(HomeScreen(), animated: true)
        print("tappedSelectPhotoPage")
        
        
    }
}
