//
//  AddingAnimalViewController.swift
//  project
//
//  Created by Evelina on 29.05.2022.
//

import UIKit
import Photos
import PhotosUI

protocol AddingAnimalViewProtocol {
    func showAlert(alert: UIAlertController)
}

class AddingAnimalViewController: UIViewController, AddingAnimalViewProtocol {

    @IBOutlet weak var animalNameTextField: UITextField!
    @IBOutlet weak var animalInfoTextField: UITextField!
    var shelter: Shelter?
    var addingAnimalPresenter: AddingAnimalPresenterProtocol!
    
    private var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addPhotosAction(_ sender: Any) {
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.getPhotoFromLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.getPhotoFromCamera()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveAnimalAction(_ sender: Any) {
        addingAnimalPresenter.saveAnimal(images: images,
                                         name: animalNameTextField.text ?? "",
                                         animalInfo: animalInfoTextField.text ?? "",
                                         shelter: shelter)
    }
    
    private func getPhotoFromLibrary() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 10
        config.filter = .images
        
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        
        present(vc, animated: true)
    }
    
    private func getPhotoFromCamera() {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .camera
        pickerController.allowsEditing = true
        pickerController.delegate = self
        
        present(pickerController, animated: true, completion: nil)
    }
}
extension AddingAnimalViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                self.images.append(image)
            }
        }
    }
}

extension AddingAnimalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.images.append(image)
    }
}
