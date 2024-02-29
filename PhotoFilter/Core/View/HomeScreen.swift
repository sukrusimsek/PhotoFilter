//
//  ViewController.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 25.02.2024.
//

import UIKit
import CoreImage
import AVFoundation

protocol HomeScreenInterface: AnyObject {
    func configureVC()
    func configureImagePickerButton()
    func configureStackView()
    func configureInputView()
    func configureCollectionView()
    func configureOutputView()
    func useCamera()
    func openGallery()
    func openCamera()
    func reloadData()
    
}
final class HomeScreen: UIViewController {
    private let imagePicker = UIImagePickerController()
    private let viewModel = HomeViewModel()
    private let stackView = UIStackView()
    private var imageViewInput = UIImageView()
    private var collectionView: UICollectionView!
    private var imageViewOutput = UIImageView()
    
    private var imageCollection = [UIImage]()
    private let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}

extension HomeScreen: HomeScreenInterface, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureVC() {
        imagePicker.delegate = self
        
    }
    func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .gray
        stackView.layer.cornerRadius = 16
        stackView.layer.masksToBounds = true
        stackView.distribution = .fillProportionally
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    func configureInputView() {
        imageViewInput.translatesAutoresizingMaskIntoConstraints = false
        imageViewInput.image = UIImage(named: "default")
        imageViewInput.layer.cornerRadius = 12
        imageViewInput.layer.masksToBounds = true
        imageViewInput.contentMode = .scaleAspectFill
        imageViewInput.backgroundColor = .white
        stackView.addArrangedSubview(imageViewInput)
        NSLayoutConstraint.activate([
            imageViewInput.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            imageViewInput.heightAnchor.constraint(equalToConstant: view.frame.size.height/3.5)
        ])
    }
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .blue
        collectionView.layer.cornerRadius = 16
        collectionView.layer.masksToBounds = true
        collectionView.isPagingEnabled = true
        
        stackView.addArrangedSubview(collectionView)
        
        
    }
    //CollectionView Funcs.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
        //imageCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let image = UIImageView(frame: cell.bounds)
        image.image = imageCollection[indexPath.item]
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .red
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        cell.contentView.addSubview(image)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    func configureOutputView() {
        imageViewOutput.translatesAutoresizingMaskIntoConstraints = false
        imageViewOutput.image = UIImage(named: "default")
        imageViewOutput.layer.cornerRadius = 12
        imageViewOutput.layer.masksToBounds = true
        imageViewOutput.contentMode = .scaleAspectFill
        imageViewOutput.backgroundColor = .lightText
        stackView.addArrangedSubview(imageViewOutput)
        NSLayoutConstraint.activate([
            imageViewOutput.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            imageViewOutput.heightAnchor.constraint(equalToConstant: view.frame.size.height/3.5)
        ])
    }
    func configureImagePickerButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.setTitle("Fotoğraf Seç", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        stackView.addArrangedSubview(button)
    }
    @objc func buttonTapped() {
        print("button tapped")
        //Alert for Choosing
        let alertControllerForImage = UIAlertController(title: "Fotoğraf Seç", message: nil, preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Galeri", style: .default) { (_) in
            self.openGallery()
        }
        alertControllerForImage.addAction(galleryAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Kamera", style: .default) { (_) in
                self.openCamera()
            }
            alertControllerForImage.addAction(cameraAction)
        }
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        alertControllerForImage.addAction(cancelAction)
        present(alertControllerForImage, animated: true, completion: nil)
    }
    func useCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.openCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.openCamera()
                    }
                }
            }
        case .restricted, .denied:
            break
        @unknown default:
            break
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("Error in Open Gallery")
        }
    }
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("Error in Open Camera")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewInput.image = pickedImage
            
            let imageService = ImageFilterService()
            DispatchQueue.main.async {
                //let outputImage = imageService.applyMonochrom(to: pickedImage, color: CIColor(red: 1, green: 0, blue: 0), intensity: 1.0)//Add controller for intensity
                
                //let outputImage = imageService.applyColorControl(to: pickedImage, brightness: -0.4, contrast: 1.0, saturation: 0.5)
                //let outputImage = imageService.applyBokehBlur(to: pickedImage, ringSize: 1, ringAmount: 0, softness: 1, radius: 20)
                
                //Vıbrance will add start views.
                //let outputImage = imageService.applyVibrance(to: pickedImage, amount: 2.0)
                
                //let outputImage = imageService.applyPixellate(to: pickedImage, center: CGPoint(x: 150, y: 150), scale: 30)
                
                //let outputImage = imageService.applyHexagonalPixellate(to: pickedImage)
                
                
                
                let outputImage = imageService.applyBoxBlur(to: pickedImage)
                
                
                self.imageViewOutput.image = outputImage
            }

            dismiss(animated: true,completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    }
}
