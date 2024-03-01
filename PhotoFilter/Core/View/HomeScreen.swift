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
        imageViewInput.contentMode = .scaleAspectFit
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
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .lightGray
        collectionView.layer.cornerRadius = 8
        collectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        collectionView.layer.masksToBounds = true
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")
        stackView.addArrangedSubview(collectionView)
    }
    
    func configureOutputView() {
        imageViewOutput.translatesAutoresizingMaskIntoConstraints = false
        imageViewOutput.image = UIImage(named: "default")
        imageViewOutput.layer.cornerRadius = 12
        imageViewOutput.layer.masksToBounds = true
        imageViewOutput.contentMode = .scaleAspectFit
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
    //CollectionView Funcs.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        let filteredImage = imageCollection[indexPath.item]
        cell.setupCell(filteredImage)
        cell.imageForFilter.image = filteredImage

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 110, height: 110)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageViewOutput.image = imageCollection[indexPath.item]
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewInput.image = pickedImage
            imageCollection.removeAll()
            
            let imageService = ImageFilterService()
            DispatchQueue.global().async { [weak self] in
                DispatchQueue.main.async {
                    let outputImageVibrance = imageService.applyVibrance(to: pickedImage, amount: 2.0)
                    self?.imageCollection.append(outputImageVibrance ?? .default)
                    let outputImageMonochrom = imageService.applyMonochrom(to: pickedImage, color: CIColor(red: 1, green: 0, blue: 0), intensity: 1.0)
                    self?.imageCollection.append(outputImageMonochrom ?? .default)
                    let outputImageColorControl = imageService.applyColorControl(to: pickedImage, brightness: -0.4, contrast: 1.0, saturation: 0.5)
                    self?.imageCollection.append(outputImageColorControl ?? .default)
                    let outputImageBokehBlur = imageService.applyBokehBlur(to: pickedImage, ringSize: 1, ringAmount: 0, softness: 1, radius: 20)
                    self?.imageCollection.append(outputImageBokehBlur ?? .default)
                    let outputImagePixellate = imageService.applyPixellate(to: pickedImage, center: CGPoint(x: 150, y: 150), scale: 30)
                    self?.imageCollection.append(outputImagePixellate ?? .default)
                    let outputImageHexagonalPixellate = imageService.applyHexagonalPixellate(to: pickedImage)
                    self?.imageCollection.append(outputImageHexagonalPixellate ?? .default)
                    let outputImageBoxBlur = imageService.applyBoxBlur(to: pickedImage)
                    self?.imageCollection.append(outputImageBoxBlur ?? .default)
                    let outputSepia = imageService.applySepia(to: pickedImage)
                    self?.imageCollection.append(outputSepia ?? .default)
                    let outputColorInvert = imageService.applyColorInvert(to: pickedImage)
                    self?.imageCollection.append(outputColorInvert ?? .default)
                    let outputBlur = imageService.applyBlur(to: pickedImage)
                    self?.imageCollection.append(outputBlur ?? .default)
                    
                    let outputColorControl = imageService.applyColorControl(to: pickedImage)
                    self?.imageCollection.append(outputColorControl ?? .default)
                    
                    let outputCircularScreen = imageService.applyCircularScreen(to: pickedImage)
                    self?.imageCollection.append(outputCircularScreen ?? .default)
                    
                    let outputToneCurve = imageService.applyToneCurve(to: pickedImage)
                    self?.imageCollection.append(outputToneCurve ?? .default)
                    
                    let outputTemperatureAndTint = imageService.applyTemperatureAndTint(to: pickedImage)
                    self?.imageCollection.append(outputTemperatureAndTint ?? .default)
                    
                    let outputSRGBToneCurveToLinear = imageService.applySRGBToneCurveToLinear(to: pickedImage)
                    self?.imageCollection.append(outputSRGBToneCurveToLinear ?? .default)
                    
                    let outputPhotoEffectTransfer = imageService.applyPhotoEffectTransfer(to: pickedImage)
                    self?.imageCollection.append(outputPhotoEffectTransfer ?? .default)
                    
                    let outputPhotoEffectNoir = imageService.applyPhotoEffectNoir(to: pickedImage)
                    self?.imageCollection.append(outputPhotoEffectNoir ?? .default)
                    
                    let outputPhotoEffectMono = imageService.applyPhotoEffectMono(to: pickedImage)
                    self?.imageCollection.append(outputPhotoEffectMono ?? .default)
                    
                    let outputPhotoEffectInstant = imageService.applyPhotoEffectInstant(to: pickedImage)
                    self?.imageCollection.append(outputPhotoEffectInstant ?? .default)
                    
                    let outputPhotoEffectFade = imageService.applyPhotoEffectFade(to: pickedImage)
                    self?.imageCollection.append(outputPhotoEffectFade ?? .default)
                    
                    let outputNoiseReduction = imageService.applyNoiseReduction(to: pickedImage)
                    self?.imageCollection.append(outputNoiseReduction ?? .default)
                    
                    let outputMotionBlur = imageService.applyMotionBlur(to: pickedImage)
                    self?.imageCollection.append(outputMotionBlur ?? .default)
                    
                    let outputMinimumComponent = imageService.applyMinimumComponent(to: pickedImage)
                    self?.imageCollection.append(outputMinimumComponent ?? .default)
                    
                    let outputMedian = imageService.applyMedian(to: pickedImage)
                    self?.imageCollection.append(outputMedian ?? .default)
                    
                    let outputLinearToSRGBTCurve = imageService.applyLinearToSRGBToneCurve(to: pickedImage)
                    self?.imageCollection.append(outputLinearToSRGBTCurve ?? .default)
                    
                    let outputHueAdjust = imageService.applyHueAdjuc(to: pickedImage)
                    self?.imageCollection.append(outputHueAdjust ?? .default)
                    
                    let outputHatchedScreen = imageService.applyHatchedScreen(to: pickedImage)
                    self?.imageCollection.append(outputHatchedScreen ?? .default)
                    
                    let outputGammaAdjust = imageService.applyGammaAdjust(to: pickedImage)
                    self?.imageCollection.append(outputGammaAdjust ?? .default)
                    
                    let outputFalseColor = imageService.applyFalseColor(to: pickedImage)
                    self?.imageCollection.append(outputFalseColor ?? .default)
                    
                    let outputEdgeWork = imageService.applyEdgeWork(to: pickedImage)
                    self?.imageCollection.append(outputEdgeWork ?? .default)
                    
                    let outputDotScreen = imageService.applyDotScreen(to: pickedImage)
                    self?.imageCollection.append(outputDotScreen ?? .default)
                    
                    let outputDocumentEnhancer = imageService.applyDocumentEnhancer(to: pickedImage)
                    self?.imageCollection.append(outputDocumentEnhancer ?? .default)
                    
                    let outputDither = imageService.applyDither(to: pickedImage)
                    self?.imageCollection.append(outputDither ?? .default)
                    
                    let outputDiscBlur = imageService.applyDiscBlur(to: pickedImage)
                    self?.imageCollection.append(outputDiscBlur ?? .default)
                    
                    let outputDepthOfField = imageService.applyDepthOfField(to: pickedImage)
                    self?.imageCollection.append(outputDepthOfField ?? .default)
                    
                    let outputBloom = imageService.applyBloomFilter(to: pickedImage)
                    self?.imageCollection.append(outputBloom ?? .default)
                    
                    let outputCrystallize = imageService.applyCrystallize(to: pickedImage)
                    self?.imageCollection.append(outputCrystallize ?? .default)
                    
                    let outputConvolution3x3 = imageService.applyConvolution3x3(to: pickedImage)
                    self?.imageCollection.append(outputConvolution3x3 ?? .default)
                    
                    let outputConvolution7x7 = imageService.applyConvolution7x7(to: pickedImage)
                    self?.imageCollection.append(outputConvolution7x7 ?? .default)
                    
                    let outputComicEffect = imageService.applyComicEffect(to: pickedImage)
                    self?.imageCollection.append(outputComicEffect ?? .default)
                    
                    
                    self?.imageViewOutput.image = outputImageMonochrom
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
            }

            dismiss(animated: true) {[weak self] in
                self?.collectionView.reloadData()
            }
        }
        

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    }
}
