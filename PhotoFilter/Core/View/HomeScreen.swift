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
//    func configureInputView()
    func configureCollectionView()
    func configureOutputView()
    func useCamera()
    func openGallery()
    func openCamera()
    func reloadData()
    func configureShareButton()
    
}
final class HomeScreen: UIViewController {
    private let imagePicker = UIImagePickerController()
    private let viewModel = HomeViewModel()
    private let stackView = UIStackView()
    private lazy var imageViewInput = UIImageView()
    private var collectionView: UICollectionView!
    private lazy var imageViewOutput = UIImageView()
    private lazy var imageCollection = [UIImage]()
    private let imagePickerButton = UIButton()
    private let shareButton = UIButton()
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
        view.backgroundColor = .red
        
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
//    func configureInputView() {
//        imageViewInput.translatesAutoresizingMaskIntoConstraints = false
//        imageViewInput.image = UIImage(named: "default")
//        imageViewInput.layer.cornerRadius = 12
//        imageViewInput.layer.masksToBounds = true
//        imageViewInput.contentMode = .scaleAspectFit
//        imageViewInput.backgroundColor = .white
//        stackView.addArrangedSubview(imageViewInput)
//        NSLayoutConstraint.activate([
//            imageViewInput.widthAnchor.constraint(equalToConstant: view.frame.size.width),
//            imageViewInput.heightAnchor.constraint(equalToConstant: view.frame.size.height/3.5)
//        ])
//    }
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
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
            imageViewOutput.heightAnchor.constraint(equalToConstant: view.frame.size.height/1.75)
        ])
    }
    func configureImagePickerButton() {
        imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        imagePickerButton.backgroundColor = .lightGray
        imagePickerButton.setTitle("Fotoğraf Seç", for: .normal)
        imagePickerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        imagePickerButton.layer.cornerRadius = 12
        imagePickerButton.layer.masksToBounds = true
        stackView.addArrangedSubview(imagePickerButton)
    }
    func configureShareButton() {
//        shareButton.translatesAutoresizingMaskIntoConstraints = false
//        shareButton.setTitle("Share", for: .normal)
//        shareButton.setTitleColor(.black, for: .normal)
//        //shareButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
////        shareButton.setTitleShadowColor(.black, for: .normal)
//        let blur = UIBlurEffect(style: .light)
//        let blurView = UIVisualEffectView(effect: blur)
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        shareButton.frame = .zero
//        blurView.frame = .zero
//        shareButton.backgroundColor = .clear
//        shareButton.layer.cornerRadius = 10
//        shareButton.layer.masksToBounds = true
//        blurView.contentView.addSubview(shareButton)
//        blurView.leadingAnchor.constraint(equalTo: shareButton.leadingAnchor).isActive = true
//        blurView.trailingAnchor.constraint(equalTo: shareButton.trailingAnchor).isActive = true
//        blurView.topAnchor.constraint(equalTo: shareButton.topAnchor).isActive = true
//        blurView.bottomAnchor.constraint(equalTo: shareButton.bottomAnchor).isActive = true
//        imageViewOutput.addSubview(blurView)
//        NSLayoutConstraint.activate([
//            shareButton.leadingAnchor.constraint(equalTo: imageViewOutput.leadingAnchor, constant: 10),
//            shareButton.topAnchor.constraint(equalTo: imageViewOutput.topAnchor, constant: 10)
//        ])
//        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(.black, for: .normal)
        shareButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        
        shareButton.setTitleShadowColor(.black, for: .normal)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.layer.cornerRadius = 12
        shareButton.layer.masksToBounds = true
        shareButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageViewOutput.isUserInteractionEnabled = true
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isUserInteractionEnabled = false
        blurView.frame = shareButton.bounds
        blurView.translatesAutoresizingMaskIntoConstraints = false
        shareButton.insertSubview(blurView, at: 0)
        blurView.leadingAnchor.constraint(equalTo: shareButton.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: shareButton.trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: shareButton.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: shareButton.bottomAnchor).isActive = true
        
        imageViewOutput.addSubview(shareButton)
        NSLayoutConstraint.activate([
            shareButton.leadingAnchor.constraint(equalTo: imageViewOutput.leadingAnchor, constant: 10),
            shareButton.topAnchor.constraint(equalTo: imageViewOutput.topAnchor, constant: 10)
        ])
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)


    }
    
    @objc func shareButtonTapped() {
        print("shareButtonTapped")
        if imageViewOutput.image != UIImage(named: "default") {
            let imageShare = [imageViewOutput.image]
            let activityViewController = UIActivityViewController(activityItems: imageShare as [Any], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true)
        } else {
            let alertController = UIAlertController(title: "", message: "Not found the photo", preferredStyle: .alert)
            self.present(alertController, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                alertController.dismiss(animated: true)
            }
        }
        
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
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                  guard let self = self else { return }
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
        print("index: \(indexPath.item + 1)")
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let data: Data? = pickedImage.jpegData(compressionQuality: 0)
            let resultImage = UIImage(data: data!)
            imageViewInput.image = resultImage
            imageCollection.removeAll()
            
            let imageService = ImageFilterService()
                DispatchQueue.main.async {
                    let outputImageVibrance = imageService.applyVibrance(to: resultImage ?? .default, amount: 2.0)
                    self.imageCollection.append(outputImageVibrance ?? .default)
                    let outputImageMonochrom = imageService.applyMonochrom(to: resultImage ?? .default, color: CIColor(red: 1, green: 0, blue: 0), intensity: 1.0)
                    self.imageCollection.append(outputImageMonochrom ?? .default)
                    let outputImageColorControl = imageService.applyColorControl(to: resultImage ?? .default, brightness: -0.4, contrast: 1.0, saturation: 0.5)
                    self.imageCollection.append(outputImageColorControl ?? .default)
                    let outputImagePixellate = imageService.applyPixellate(to: resultImage ?? .default, center: CGPoint(x: 150, y: 150), scale: 30)
                    self.imageCollection.append(outputImagePixellate ?? .default)
                    
                    let outputImageHexagonalPixellate = imageService.applyHexagonalPixellate(to: resultImage ?? .default)
                    self.imageCollection.append(outputImageHexagonalPixellate ?? .default)
                    let outputImageBoxBlur = imageService.applyBoxBlur(to: resultImage ?? .default)
                    self.imageCollection.append(outputImageBoxBlur ?? .default)
                    let outputColorInvert = imageService.applyColorInvert(to: resultImage ?? .default)
                    self.imageCollection.append(outputColorInvert ?? .default)
                    let outputMinimumComponent = imageService.applyMinimumComponent(to: resultImage ?? .default)
                    self.imageCollection.append(outputMinimumComponent ?? .default)
                    let outputColorControl = imageService.applyColorControl(to: resultImage ?? .default)
                    self.imageCollection.append(outputColorControl ?? .default)
                    
                    let outputCircularScreen = imageService.applyCircularScreen(to: resultImage ?? .default)
                    self.imageCollection.append(outputCircularScreen ?? .default)
                    
                    let outputToneCurve = imageService.applyToneCurve(to: resultImage ?? .default)
                    self.imageCollection.append(outputToneCurve ?? .default)
                    
                    let outputTemperatureAndTint = imageService.applyTemperatureAndTint(to: resultImage ?? .default)
                    self.imageCollection.append(outputTemperatureAndTint ?? .default)
                    
                    let outputSRGBToneCurveToLinear = imageService.applySRGBToneCurveToLinear(to: resultImage ?? .default)
                    self.imageCollection.append(outputSRGBToneCurveToLinear ?? .default)
                    
                    let outputPhotoEffectTransfer = imageService.applyPhotoEffectTransfer(to: resultImage ?? .default)
                    self.imageCollection.append(outputPhotoEffectTransfer ?? .default)
                    
                    let outputPhotoEffectNoir = imageService.applyPhotoEffectNoir(to: resultImage ?? .default)
                    self.imageCollection.append(outputPhotoEffectNoir ?? .default)
                    
                    let outputPhotoEffectMono = imageService.applyPhotoEffectMono(to: resultImage ?? .default)
                    self.imageCollection.append(outputPhotoEffectMono ?? .default)
                    
                    let outputPhotoEffectInstant = imageService.applyPhotoEffectInstant(to: resultImage ?? .default)
                    self.imageCollection.append(outputPhotoEffectInstant ?? .default)
                    
                    let outputPhotoEffectFade = imageService.applyPhotoEffectFade(to: resultImage ?? .default)
                    self.imageCollection.append(outputPhotoEffectFade ?? .default)
                    
                    let outputNoiseReduction = imageService.applyNoiseReduction(to: resultImage ?? .default)
                    self.imageCollection.append(outputNoiseReduction ?? .default)
                    
                    let outputMotionBlur = imageService.applyMotionBlur(to: resultImage ?? .default)
                    self.imageCollection.append(outputMotionBlur ?? .default)
                    
                    
                    
                    let outputMedian = imageService.applyMedian(to: resultImage ?? .default)
                    self.imageCollection.append(outputMedian ?? .default)
                    
                    let outputLinearToSRGBTCurve = imageService.applyLinearToSRGBToneCurve(to: resultImage ?? .default)
                    self.imageCollection.append(outputLinearToSRGBTCurve ?? .default)
                    
                    let outputHueAdjust = imageService.applyHueAdjuc(to: resultImage ?? .default)
                    self.imageCollection.append(outputHueAdjust ?? .default)
                    
                    let outputHatchedScreen = imageService.applyHatchedScreen(to: resultImage ?? .default)
                    self.imageCollection.append(outputHatchedScreen ?? .default)
                    
                    let outputGammaAdjust = imageService.applyGammaAdjust(to: resultImage ?? .default)
                    self.imageCollection.append(outputGammaAdjust ?? .default)
                    
                    let outputFalseColor = imageService.applyFalseColor(to: resultImage ?? .default)
                    self.imageCollection.append(outputFalseColor ?? .default)
                    
                    let outputEdgeWork = imageService.applyEdgeWork(to: resultImage ?? .default)
                    self.imageCollection.append(outputEdgeWork ?? .default)
                    
                    let outputDotScreen = imageService.applyDotScreen(to: resultImage ?? .default)
                    self.imageCollection.append(outputDotScreen ?? .default)
                    
                    let outputDocumentEnhancer = imageService.applyDocumentEnhancer(to: resultImage ?? .default)
                    self.imageCollection.append(outputDocumentEnhancer ?? .default)
//                    
//                    let outputDither = imageService.applyDither(to: pickedImage)
//                    self?.imageCollection.append(outputDither ?? .default)
//                    
//                    let outputCrystallize = imageService.applyCrystallize(to: pickedImage)
//                    self?.imageCollection.append(outputCrystallize ?? .default)
//                    
//                    let outputConvolution3x3 = imageService.applyConvolution3x3(to: pickedImage)
//                    self?.imageCollection.append(outputConvolution3x3 ?? .default)
//                    
//                    let outputConvolution7x7 = imageService.applyConvolution7x7(to: pickedImage)
//                    self?.imageCollection.append(outputConvolution7x7 ?? .default)
//                    
//                    let outputComicEffect = imageService.applyComicEffect(to: pickedImage)
//                    self?.imageCollection.append(outputComicEffect ?? .default)
                    
                    
                    self.imageViewOutput.image = outputImageMonochrom
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
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
