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
    func configureSaveButton()
    func configureShowOriginalButton()
    
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
    private let saveButton = UIButton()
    private let showOriginalButton = UIButton()
    private var selectedIndex: Int?
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
        imageViewOutput.contentMode = .scaleAspectFill
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
        imagePickerButton.setTitle("Select Photo", for: .normal)
        imagePickerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        imagePickerButton.layer.cornerRadius = 12
        imagePickerButton.layer.masksToBounds = true
        stackView.addArrangedSubview(imagePickerButton)
    }
    func configureShareButton() {
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(.black, for: .normal)
        shareButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        shareButton.setTitleShadowColor(.black, for: .normal)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.layer.cornerRadius = 12
        shareButton.layer.masksToBounds = true
        shareButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageViewOutput.isUserInteractionEnabled = true
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
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
    func configureSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        saveButton.setTitleShadowColor(.black, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.layer.cornerRadius = 12
        saveButton.layer.masksToBounds = true
        saveButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageViewOutput.isUserInteractionEnabled = true
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isUserInteractionEnabled = false
        blurView.frame = saveButton.bounds
        blurView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.insertSubview(blurView, at: 0)
        blurView.leadingAnchor.constraint(equalTo: saveButton.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: saveButton.trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: saveButton.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor).isActive = true
        imageViewOutput.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: imageViewOutput.leadingAnchor, constant: 10),
            saveButton.bottomAnchor.constraint(equalTo: imageViewOutput.bottomAnchor, constant: -10)
        ])
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
    }
    func configureShowOriginalButton() {
        showOriginalButton.translatesAutoresizingMaskIntoConstraints = false
        showOriginalButton.setTitle("Original", for: .normal)
        showOriginalButton.setTitleColor(.black, for: .normal)
        showOriginalButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        showOriginalButton.setTitleShadowColor(.black, for: .normal)
        showOriginalButton.translatesAutoresizingMaskIntoConstraints = false
        showOriginalButton.layer.cornerRadius = 12
        showOriginalButton.layer.masksToBounds = true
        showOriginalButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        showOriginalButton.isUserInteractionEnabled = true
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isUserInteractionEnabled = false
        blurView.frame = showOriginalButton.bounds
        blurView.translatesAutoresizingMaskIntoConstraints = false
        showOriginalButton.insertSubview(blurView, at: 0)
        blurView.leadingAnchor.constraint(equalTo: showOriginalButton.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: showOriginalButton.trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: showOriginalButton.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: showOriginalButton.bottomAnchor).isActive = true
        imageViewOutput.addSubview(showOriginalButton)
        NSLayoutConstraint.activate([
            showOriginalButton.trailingAnchor.constraint(equalTo: imageViewOutput.trailingAnchor, constant: -10),
            showOriginalButton.bottomAnchor.constraint(equalTo: imageViewOutput.bottomAnchor, constant: -10)
        ])
        showOriginalButton.addTarget(self, action: #selector(showOriginalButtonTapped), for: .touchDown)
        
        showOriginalButton.addTarget(self, action: #selector(showOriginalButtonTappedOutside), for: .touchUpInside)
        showOriginalButton.addTarget(self, action: #selector(showOriginalButtonTappedOutside), for: .touchUpOutside)

    }
    @objc func showOriginalButtonTapped() {
        print("showOriginalButtonTapped")
        if imageViewOutput.image != UIImage(named: "default") {
            imageViewOutput.image = imageViewInput.image
        }
    }
    @objc func showOriginalButtonTappedOutside() {
        if imageViewOutput.image != UIImage(named: "default") {
            guard let index = selectedIndex, index < imageCollection.count else {
                return
            }
            print("Show last photos in results")
            imageViewOutput.image = imageCollection[index]
        } else {
            alertNoAction(message: "Not Found The Photo")
        }
    }
    @objc func saveButtonTapped() {
        print("saveButtonTapped")
        guard let imageToSave = imageViewOutput.image else {
                alertNoAction(message: "Not found photo")
        return
        }
        if imageViewOutput.image != UIImage(named: "default") {
            UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            alertNoAction(message: "Save Successful")
        } else {
            alertNoAction(message: "Not Found The Photo")
        }
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Found error at saving the image: \(error.localizedDescription)")
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
            let filename = "imageBySukruSimsek_\(dateFormatter.string(from: .now)).jpg"
            print("Image saved to gallery with filename: \(filename)")
        }
    }
    @objc func shareButtonTapped() {
        print("shareButtonTapped")
        if imageViewOutput.image != UIImage(named: "default") {
            let imageShare = [imageViewOutput.image]
            let activityViewController = UIActivityViewController(activityItems: imageShare as [Any], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true)
        } else {
            alertNoAction(message: "Not Found The Photo")
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
        
        selectImage(at: indexPath.item)
        
        print("index: \(indexPath.item + 1)")
        
        
    }
    ///selectImage func for take the index for change original
    func selectImage(at index: Int) {
        if index < imageCollection.count {
            imageViewOutput.image = imageCollection[index]
            selectedIndex = index
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let resultImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            imageViewInput.image = resultImage
            imageCollection.removeAll()
            
            let imageService = ImageFilterService()
                DispatchQueue.main.async {
                    let outputImageVibrance = imageService.applyVibrance(to: resultImage , amount: 2.0)
                    self.imageCollection.append(outputImageVibrance ?? .default)
                    let outputImageMonochrom = imageService.applyMonochrom(to: resultImage, color: CIColor(red: 1, green: 0, blue: 0), intensity: 1.0)
                    self.imageCollection.append(outputImageMonochrom ?? .default)
                    let outputImageColorControl = imageService.applyColorControl(to: resultImage, brightness: -0.4, contrast: 1.0, saturation: 0.5)
                    self.imageCollection.append(outputImageColorControl ?? .default)
                    let outputImagePixellate = imageService.applyPixellate(to: resultImage, center: CGPoint(x: 150, y: 150), scale: 30)
                    self.imageCollection.append(outputImagePixellate ?? .default)
                    
                    let outputImageHexagonalPixellate = imageService.applyHexagonalPixellate(to: resultImage)
                    self.imageCollection.append(outputImageHexagonalPixellate ?? .default)
                    let outputImageBoxBlur = imageService.applyBoxBlur(to: resultImage)
                    self.imageCollection.append(outputImageBoxBlur ?? .default)
                    let outputColorInvert = imageService.applyColorInvert(to: resultImage)
                    self.imageCollection.append(outputColorInvert ?? .default)
                    let outputMinimumComponent = imageService.applyMinimumComponent(to: resultImage)
                    self.imageCollection.append(outputMinimumComponent ?? .default)
                    let outputColorControl = imageService.applyColorControl(to: resultImage)
                    self.imageCollection.append(outputColorControl ?? .default)
                    
                    let outputCircularScreen = imageService.applyCircularScreen(to: resultImage)
                    self.imageCollection.append(outputCircularScreen ?? .default)
                    
                    let outputToneCurve = imageService.applyToneCurve(to: resultImage)
                    self.imageCollection.append(outputToneCurve ?? .default)
                    
                    let outputTemperatureAndTint = imageService.applyTemperatureAndTint(to: resultImage)
                    self.imageCollection.append(outputTemperatureAndTint ?? .default)
                    
                    let outputSRGBToneCurveToLinear = imageService.applySRGBToneCurveToLinear(to: resultImage)
                    self.imageCollection.append(outputSRGBToneCurveToLinear ?? .default)
                    
                    let outputPhotoEffectTransfer = imageService.applyPhotoEffectTransfer(to: resultImage)
                    self.imageCollection.append(outputPhotoEffectTransfer ?? .default)
                    
                    let outputPhotoEffectNoir = imageService.applyPhotoEffectNoir(to: resultImage)
                    self.imageCollection.append(outputPhotoEffectNoir ?? .default)
                    
                    let outputPhotoEffectMono = imageService.applyPhotoEffectMono(to: resultImage)
                    self.imageCollection.append(outputPhotoEffectMono ?? .default)
                    
                    let outputPhotoEffectInstant = imageService.applyPhotoEffectInstant(to: resultImage)
                    self.imageCollection.append(outputPhotoEffectInstant ?? .default)
                    
                    let outputPhotoEffectFade = imageService.applyPhotoEffectFade(to: resultImage)
                    self.imageCollection.append(outputPhotoEffectFade ?? .default)
                    
                    let outputNoiseReduction = imageService.applyNoiseReduction(to: resultImage)
                    self.imageCollection.append(outputNoiseReduction ?? .default)
                    
                    let outputMotionBlur = imageService.applyMotionBlur(to: resultImage)
                    self.imageCollection.append(outputMotionBlur ?? .default)
                    
                    
                    
                    let outputMedian = imageService.applyMedian(to: resultImage)
                    self.imageCollection.append(outputMedian ?? .default)
                    
                    let outputLinearToSRGBTCurve = imageService.applyLinearToSRGBToneCurve(to: resultImage)
                    self.imageCollection.append(outputLinearToSRGBTCurve ?? .default)
                    
                    let outputHueAdjust = imageService.applyHueAdjuc(to: resultImage)
                    self.imageCollection.append(outputHueAdjust ?? .default)
                    
                    let outputHatchedScreen = imageService.applyHatchedScreen(to: resultImage)
                    self.imageCollection.append(outputHatchedScreen ?? .default)
                    
                    let outputGammaAdjust = imageService.applyGammaAdjust(to: resultImage)
                    self.imageCollection.append(outputGammaAdjust ?? .default)
                    
                    let outputFalseColor = imageService.applyFalseColor(to: resultImage)
                    self.imageCollection.append(outputFalseColor ?? .default)
                    
                    let outputEdgeWork = imageService.applyEdgeWork(to: resultImage,radius: 2)
                    self.imageCollection.append(outputEdgeWork ?? .default)
                    
                    let outputDotScreen = imageService.applyDotScreen(to: resultImage)
                    self.imageCollection.append(outputDotScreen ?? .default)
                    
                    let outputDocumentEnhancer = imageService.applyDocumentEnhancer(to: resultImage)
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
