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
    func configureOutputView()
    func useCamera()
    
}
final class HomeScreen: UIViewController {
    let imagePicker = UIImagePickerController()
    private let viewModel = HomeViewModel()
    let stackView = UIStackView()
    var imageViewInput = UIImageView()
    var imageViewOutput = UIImageView()
    
    let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
}

extension HomeScreen: HomeScreenInterface, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func configureVC() {
        imagePicker.delegate = self
        
    }
    func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .blue
        stackView.layer.cornerRadius = 16
        stackView.layer.masksToBounds = true
        stackView.distribution = .fillProportionally
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
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
            imageViewInput.heightAnchor.constraint(equalToConstant: view.frame.size.height/2.75)
        ])
    }
    func configureOutputView() {
        imageViewOutput.translatesAutoresizingMaskIntoConstraints = false
        imageViewOutput.image = UIImage(named: "default")
        imageViewOutput.layer.cornerRadius = 12
        imageViewOutput.layer.masksToBounds = true
        imageViewOutput.contentMode = .scaleAspectFill
        imageViewOutput.backgroundColor = .cyan
        stackView.addArrangedSubview(imageViewOutput)
        NSLayoutConstraint.activate([
            imageViewOutput.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            imageViewOutput.heightAnchor.constraint(equalToConstant: view.frame.size.height/2.75)
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
            
            
            DispatchQueue.main.async {
                let outputImage = applySepiaFilter(to: pickedImage)
                self.imageViewOutput.image = outputImage
            }

            dismiss(animated: true,completion: nil)
        }
        func applySepiaFilter(to inputImage: UIImage) -> UIImage? {
            guard let filter = CIFilter(name: "CISepiaTone") else { return nil }
            let ciInput = CIImage(image: inputImage)
            filter.setValue(ciInput, forKey: kCIInputImageKey)
            filter.setValue(0.8, forKey: kCIInputIntensityKey) // Sepia yoğunluğunu ayarlayın
            
            let context = CIContext(options: nil)
            if let outputImage = filter.outputImage,
               let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
            return nil
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    }
}
