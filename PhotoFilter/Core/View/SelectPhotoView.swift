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
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}
extension SelectPhotoView: SelectPhotoViewInterface {
    func configureVC() {
        
        view.backgroundColor = .darkGray
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(rgb: 0x101010)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                          .font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(goToSettingScreenTapped), imageName: "settingsButton")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(tappedBackPage), imageName: "backButton", height: 32, width: 32)
        
        
    }
    @objc private func tappedBackPage() {
        print("tappedBackPage")
    }
    @objc private func goToSettingScreenTapped() {
        print("goToSettingScreenTapped")
        navigationController?.pushViewController(SettingScreen(), animated: true)
        
    }
    func configureTabView() {
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.backgroundColor = UIColor(rgb: 0x101010)
        view.addSubview(tabView)
        
        NSLayoutConstraint.activate([
            tabView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075),
            tabView.widthAnchor.constraint(equalToConstant: view.frame.width),
            tabView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    func configureDefaultSelectView() {
        defaultViewButton.translatesAutoresizingMaskIntoConstraints = false
        defaultViewButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        defaultViewButton.image = UIImage(named: "defaultImage")
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
        selectPhoto.backgroundColor = UIColor(rgb: 0xDFCECE)
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
        print("tappedSelectPhotoPage")
        navigationController?.pushViewController(HomeScreen(), animated: true)
    }
}
