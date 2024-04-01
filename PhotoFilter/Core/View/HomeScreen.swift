//
//  ViewController.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 25.02.2024.
//

import UIKit
import CoreImage
import AVFoundation
import BackgroundRemoval

protocol HomeScreenInterface: AnyObject {
    func configureVC()
    func configureImagePickerButton()
    func configureCollectionView()
    func configureOutputView()
    func useCamera()
    func openGallery()
    func openCamera()
    func reloadData()
//    func configureShareButton()
    func configureSaveButton()
    func configureShowOriginalButton()
//    func configureBackgroundRemoverButton()
    func drawImage(_ image: UIImage) -> UIImage?
    func viewForCollectionViewAndSelectShow()
    func createDivider()
    
}
final class HomeScreen: UIViewController {
    private let imagePicker = UIImagePickerController()
    private let viewModel = HomeViewModel()
    private lazy var imageViewInput = UIImageView()
    private var collectionView: UICollectionView!
    private lazy var imageViewOutput = UIImageView()
    private lazy var imageCollection = [UIImage]()
    private let imagePickerButton = UIButton()
    private let shareButton = UIButton()
    private let saveButton = UIButton()
    private let showOriginalButton = UIButton(type: .custom)
    private var selectedIndex: Int?
    private let settingScreenButton = UIButton()
    private let backgroundRemoverButton = UIButton()
    private let viewForBackgroundPickerSaveShowButton = UIView()
    private let filterNames =  ["Energic","Soft","Sun","R-Light","Instant-Light","High-Dither","Dither","Slow-Dither","L-Shadow","Median","Beatiful","Pixel","Hexagon","Matte","White-Fade","Cartoon","Dark-Noir","Dark-Night","Dark -Mono","Dark-Back","L-Dark","Gamma-Dark","FacePurple","Vintage","Trapezoidal","Perpendicular","Poster-White","Animation","Thermal","X-Ray","Points"
    ]
    let homeIndicator = UIView()
    let divider = UIView()
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
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(rgb: 0x101010)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                          .font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)

        let rightSettingButton = UIBarButtonItem.menuButton(self, action: #selector(goToSettingScreenTapped), imageName: "settingsButton")
        let rightShareButton = UIBarButtonItem.menuButton(self, action: #selector(shareButtonTapped), imageName: "shareButton")
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)


        navigationItem.rightBarButtonItems = [rightSettingButton,flexibleSpace, flexibleSpace ,rightShareButton]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(tappedBackPage), imageName: "backButton", height: 32, width: 32)
        
        
        
        
        homeIndicator.translatesAutoresizingMaskIntoConstraints = false
        homeIndicator.backgroundColor = UIColor(white: 1, alpha: 0.2)
        homeIndicator.layer.cornerRadius = 1
        homeIndicator.layer.masksToBounds = true
        viewForBackgroundPickerSaveShowButton.addSubview(homeIndicator)
        
        NSLayoutConstraint.activate([
            homeIndicator.topAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.topAnchor, constant: 10),
            homeIndicator.widthAnchor.constraint(equalToConstant: 40),
            homeIndicator.centerXAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.centerXAnchor),
            homeIndicator.heightAnchor.constraint(equalToConstant: 3),
        ])
        
        
    }
    @objc func tappedBackPage() {
        print("tappedBackPage")
        navigationController?.dismiss(animated: true)
    }

    func configureOutputView() {
        imageViewOutput.translatesAutoresizingMaskIntoConstraints = false
        imageViewOutput.image = UIImage(named: "defaultImage2")
        imageViewOutput.contentMode = .scaleAspectFit
        imageViewOutput.backgroundColor = .lightText
        view.addSubview(imageViewOutput)
        NSLayoutConstraint.activate([
            imageViewOutput.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            imageViewOutput.heightAnchor.constraint(equalToConstant: view.frame.size.height/1.9),
            imageViewOutput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
        ])
    }
    
    func viewForCollectionViewAndSelectShow() {
        viewForBackgroundPickerSaveShowButton.translatesAutoresizingMaskIntoConstraints = false
        viewForBackgroundPickerSaveShowButton.backgroundColor = UIColor(rgb: 0x101010)
        
        view.addSubview(viewForBackgroundPickerSaveShowButton)
        NSLayoutConstraint.activate([
            viewForBackgroundPickerSaveShowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewForBackgroundPickerSaveShowButton.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            viewForBackgroundPickerSaveShowButton.topAnchor.constraint(equalTo: imageViewOutput.bottomAnchor),
            
        ])
    }
    func configureImagePickerButton() {
        imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        imagePickerButton.setTitle("+ Select Photo", for: .normal)
        imagePickerButton.setTitleColor(.white, for: .normal)
        imagePickerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(buttonTapped), name: NSNotification.Name("PickerViewOn"), object: nil)
        
        viewForBackgroundPickerSaveShowButton.addSubview(imagePickerButton)
        
        NSLayoutConstraint.activate([
            imagePickerButton.topAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.topAnchor, constant: 25),
            imagePickerButton.leadingAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.leadingAnchor, constant: 10),
            
        ])
    }
    
    func configureShowOriginalButton() {
        showOriginalButton.translatesAutoresizingMaskIntoConstraints = false
        if let iconImage = UIImage(named: "showOriginal")?.resized(to: CGSize(width: 32, height: 32)) {
            showOriginalButton.setImage(iconImage, for: .normal)
        }

//        showOriginalButton.imageView?.contentMode = .scaleAspectFit
        viewForBackgroundPickerSaveShowButton.addSubview(showOriginalButton)
        
        NSLayoutConstraint.activate([
            showOriginalButton.topAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.topAnchor, constant: 25),
            showOriginalButton.trailingAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.trailingAnchor, constant: -10),
        ])
        showOriginalButton.addTarget(self, action: #selector(showOriginalButtonTapped), for: .touchDown)
        showOriginalButton.addTarget(self, action: #selector(showOriginalButtonTappedOutside), for: .touchUpInside)
        showOriginalButton.addTarget(self, action: #selector(showOriginalButtonTappedOutside), for: .touchUpOutside)

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
        collectionView.layer.cornerRadius = 8
        collectionView.backgroundColor = UIColor(rgb: 0x101010)
        collectionView.layer.masksToBounds = true
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")
        viewForBackgroundPickerSaveShowButton.addSubview(collectionView)
        NSLayoutConstraint.activate([
            
            collectionView.heightAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.heightAnchor, multiplier: 0.4),
            collectionView.topAnchor.constraint(equalTo: imagePickerButton.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.trailingAnchor)
            
        ])
    }
    func configureSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.backgroundColor = .white
        saveButton.layer.cornerRadius = 24
        saveButton.layer.masksToBounds = true
        viewForBackgroundPickerSaveShowButton.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 15),
            saveButton.widthAnchor.constraint(equalToConstant: view.frame.size.width - 20),
            saveButton.centerXAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.centerXAnchor),
            saveButton.heightAnchor.constraint(equalTo: viewForBackgroundPickerSaveShowButton.heightAnchor, multiplier: 0.15)
            
        ])
        
    }
    func createDivider() {
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = UIColor(white: 1, alpha: 0.2)
        viewForBackgroundPickerSaveShowButton.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
        ])
    }
    
//    func configureShareButton() {
//        shareButton.setTitle("Share", for: .normal)
//        shareButton.setTitleColor(.black, for: .normal)
//        shareButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
//        shareButton.setTitleShadowColor(.black, for: .normal)
//        shareButton.translatesAutoresizingMaskIntoConstraints = false
//        shareButton.layer.cornerRadius = 12
//        shareButton.layer.masksToBounds = true
//        shareButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
//        imageViewOutput.isUserInteractionEnabled = true
//        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.isUserInteractionEnabled = false
//        blurView.frame = shareButton.bounds
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        shareButton.insertSubview(blurView, at: 0)
//        blurView.leadingAnchor.constraint(equalTo: shareButton.leadingAnchor).isActive = true
//        blurView.trailingAnchor.constraint(equalTo: shareButton.trailingAnchor).isActive = true
//        blurView.topAnchor.constraint(equalTo: shareButton.topAnchor).isActive = true
//        blurView.bottomAnchor.constraint(equalTo: shareButton.bottomAnchor).isActive = true
//        
//        imageViewOutput.addSubview(shareButton)
//        NSLayoutConstraint.activate([
//            shareButton.leadingAnchor.constraint(equalTo: imageViewOutput.leadingAnchor, constant: 10),
//            shareButton.topAnchor.constraint(equalTo: imageViewOutput.topAnchor, constant: 10)
//        ])
//        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
//    }

    
//    func configureBackgroundRemoverButton() {
//        backgroundRemoverButton.translatesAutoresizingMaskIntoConstraints = false
//        backgroundRemoverButton.setTitle("Remover", for: .normal)
//        backgroundRemoverButton.setTitleColor(.black, for: .normal)
//        backgroundRemoverButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
//        backgroundRemoverButton.setTitleShadowColor(.black, for: .normal)
//        backgroundRemoverButton.translatesAutoresizingMaskIntoConstraints = false
//        backgroundRemoverButton.layer.cornerRadius = 12
//        backgroundRemoverButton.layer.masksToBounds = true
//        backgroundRemoverButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        backgroundRemoverButton.isUserInteractionEnabled = true
//        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.isUserInteractionEnabled = false
//        blurView.frame = backgroundRemoverButton.bounds
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundRemoverButton.insertSubview(blurView, at: 0)
//        blurView.leadingAnchor.constraint(equalTo: backgroundRemoverButton.leadingAnchor).isActive = true
//        blurView.trailingAnchor.constraint(equalTo: backgroundRemoverButton.trailingAnchor).isActive = true
//        blurView.topAnchor.constraint(equalTo: backgroundRemoverButton.topAnchor).isActive = true
//        blurView.bottomAnchor.constraint(equalTo: backgroundRemoverButton.bottomAnchor).isActive = true
//        imageViewOutput.addSubview(backgroundRemoverButton)
//        NSLayoutConstraint.activate([
//            backgroundRemoverButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            backgroundRemoverButton.topAnchor.constraint(equalTo: imageViewOutput.topAnchor, constant: 10)
//        ])
//        backgroundRemoverButton.addTarget(self, action: #selector(backgroundRemoverButtonTapped), for: .touchUpInside)
//    }
   
    
//    @objc func backgroundRemoverButtonTapped() {
//        if imageViewOutput.image != UIImage(named: "default") {
//            let backgroundRemover = BackgroundRemoval()
//            do {
//                let resultImage = try BackgroundRemoval().removeBackground(image: imageViewOutput.image!)
//
//                let newImage2 = drawImage(resultImage)
//                let newImage = UIImage(data: newImage2!.pngData()!)
//                imageViewOutput.image = newImage
//            } catch {
//                print(error)
//            }
//        } else {
//            alertNoAction(message: "Not Found The Photo")
//        }
//        
//    }
    func drawImage(_ image: UIImage) -> UIImage? {
        guard let coreImage = image.cgImage else {
            return nil;
        }
        UIGraphicsBeginImageContext(CGSize(width: coreImage.width, height: coreImage.height))
        image.draw(in: CGRect(x: Int(0.0), y: Int(0.0), width: coreImage.width, height: coreImage.height))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage;
    }
    @objc func goToSettingScreenTapped() {
        print("goToSettingScreenTapped")
        navigationController?.pushViewController(SettingScreen(), animated: true)
        
    }
    @objc func showOriginalButtonTapped() {
        print("showOriginalButtonTapped")
        if imageViewOutput.image != UIImage(named: "defaultImage2") {
            imageViewOutput.image = imageViewInput.image
        }
    }
    @objc func showOriginalButtonTappedOutside() {
        if imageViewOutput.image != UIImage(named: "defaultImage2") {
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
        if imageViewOutput.image != UIImage(named: "defaultImage2") {
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
            let filename = "imageCreatedByPhotoFilter_\(dateFormatter.string(from: .now)).jpg"
            print("Image saved to gallery with filename: \(filename)")
        }
    }
    @objc func shareButtonTapped() {
        print("shareButtonTapped")
        if imageViewOutput.image != UIImage(named: "defaultImage2") {
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
        let alertControllerForImage = UIAlertController(title: "Select Photo", message: nil, preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (_) in
            self.openGallery()
        }
        alertControllerForImage.addAction(galleryAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                self.openCamera()
            }
            alertControllerForImage.addAction(cameraAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
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
        let filterName = filterNames[indexPath.item]
        cell.setupCell(filteredImage, text: filterName)
        cell.imageForFilter.image = filteredImage
        cell.labelForFilterName.text = filterNames[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 120, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageViewOutput.image = imageCollection[indexPath.item]
        selectImage(at: indexPath.item)
        print(filterNames[indexPath.item])
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
        if let result = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let thumbImage = result.imageCompress()
            let resultImage = thumbImage
            imageViewInput.image = resultImage
            imageCollection.removeAll()
            let imageService = ImageFilterService()
                DispatchQueue.main.async {
                    
                    let outputImageVibrance = imageService.applyVibrance(to: resultImage, amount: 2.0)//Energic
                    self.imageCollection.append(outputImageVibrance ?? .default)
                    let outputToneCurve = imageService.applyToneCurve(to: resultImage)//Soft
                    self.imageCollection.append(outputToneCurve ?? .default)
                    let outputTemperatureAndTint = imageService.applyTemperatureAndTint(to: resultImage)//Sun
                    self.imageCollection.append(outputTemperatureAndTint ?? .default)
                    let outputPhotoEffectTransfer = imageService.applyPhotoEffectTransfer(to: resultImage)//R-Light
                    self.imageCollection.append(outputPhotoEffectTransfer ?? .default)
                    let outputPhotoEffectInstant = imageService.applyPhotoEffectInstant(to: resultImage)//Instant-Light
                    self.imageCollection.append(outputPhotoEffectInstant ?? .default)
                    let outputDither3 = imageService.applyDither(to: resultImage, intensity: 0.6)//High-Dither
                    self.imageCollection.append(outputDither3 ?? .default)
                    let outputDither = imageService.applyDither(to: resultImage)//Dither
                    self.imageCollection.append(outputDither ?? .default)
                    let outputDither2 = imageService.applyDither(to: resultImage, intensity: 0.2)//Slow-Dither
                    self.imageCollection.append(outputDither2 ?? .default)
                    let outputSRGBToneCurveToLinear = imageService.applySRGBToneCurveToLinear(to: resultImage)//L-Shadow
                    self.imageCollection.append(outputSRGBToneCurveToLinear ?? .default)
                    let outputMedian = imageService.applyMedian(to: resultImage)//Median
                    self.imageCollection.append(outputMedian ?? .default)
                    let outputImageVibrance2 = imageService.applyVibrance(to: resultImage, amount: 5.0)//Beatiful
                    self.imageCollection.append(outputImageVibrance2 ?? .default)
                    let outputImagePixellate = imageService.applyPixellate(to: resultImage, center: CGPoint(x: 150, y: 150), scale: 10)//Pixel
                    self.imageCollection.append(outputImagePixellate ?? .default)
                    let outputImageHexagonalPixellate = imageService.applyHexagonalPixellate(to: resultImage, scale: 10)//Hexagon
                    self.imageCollection.append(outputImageHexagonalPixellate ?? .default)
                    let outputNoiseReduction = imageService.applyNoiseReduction(to: resultImage)//Matte
                    self.imageCollection.append(outputNoiseReduction ?? .default)
                    let outputPhotoEffectFade = imageService.applyPhotoEffectFade(to: resultImage)//White-Fade
                    self.imageCollection.append(outputPhotoEffectFade ?? .default)
                    let outputPosterize = imageService.applyPosterize(to: resultImage)//Cartoon
                    self.imageCollection.append(outputPosterize ?? .default)
                    
                    let outputPhotoEffectNoir = imageService.applyPhotoEffectNoir(to: resultImage)//Dark-Noir
                    self.imageCollection.append(outputPhotoEffectNoir ?? .default)
                    let outputMinimumComponent = imageService.applyMinimumComponent(to: resultImage)//Dark-Night
                    self.imageCollection.append(outputMinimumComponent ?? .default)
                    let outputPhotoEffectMono = imageService.applyPhotoEffectMono(to: resultImage)//Dark-Mono
                    self.imageCollection.append(outputPhotoEffectMono ?? .default)
                    let outputImageColorControl = imageService.applyColorControl(to: resultImage, brightness: -0.4, contrast: 1.0, saturation: 0.5)//Dark-Back
                    self.imageCollection.append(outputImageColorControl ?? .default)

                    let outputColorControl = imageService.applyColorControl(to: resultImage)//L-Dark
                    self.imageCollection.append(outputColorControl ?? .default)
                    let outputGammaAdjust = imageService.applyGammaAdjust(to: resultImage)//Gamma-Dark
                    self.imageCollection.append(outputGammaAdjust ?? .default)
                    
                    let outputHueAdjust = imageService.applyHueAdjuc(to: resultImage)//FacePurple
                    self.imageCollection.append(outputHueAdjust ?? .default)
                    
                    let outputFalseColor = imageService.applyFalseColor(to: resultImage)//Vintage
                    self.imageCollection.append(outputFalseColor ?? .default)
                    let outputCircularScreen = imageService.applyCircularScreen(to: resultImage,sharpness: 0.35, width: 20)//Trapezoidal
                    self.imageCollection.append(outputCircularScreen ?? .default)

                    let outputHatchedScreen = imageService.applyHatchedScreen(to: resultImage)//Perpendicular
                    self.imageCollection.append(outputHatchedScreen ?? .default)

                    let outputEdgeWork = imageService.applyEdgeWork(to: resultImage,radius: 1)//Poster-White
                    self.imageCollection.append(outputEdgeWork ?? .default)
                    
                    let outputComicEffect = imageService.applyComicEffect(to: resultImage)//Animation
                    self.imageCollection.append(outputComicEffect ?? .default)
                    
                    let outputThermal = imageService.applyThermal(to: resultImage)//Thermal
                    self.imageCollection.append(outputThermal ?? .default)
                    
                    let outputXray = imageService.applyXray(to: resultImage)//X-Ray
                    self.imageCollection.append(outputXray ?? .default)
                    
                    let outputPointillize = imageService.applyPointillize(to: resultImage)//Points
                    self.imageCollection.append(outputPointillize ?? .default)

                    self.imageViewOutput.image = outputImageVibrance
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

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
