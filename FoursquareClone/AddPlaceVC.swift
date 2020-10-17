//
//  AddPlaceVC.swift
//  FoursquareClone
//
//  Created by Radhi Mighri on 16/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var placenameText: UITextField!
    @IBOutlet weak var placetypeText: UITextField!
    @IBOutlet weak var placeatmosphereText: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func nextBtnClicked(_ sender: UIButton) {
        
        if placenameText.text != "" && placetypeText.text != "" && placeatmosphereText.text != "" {
            if let chosenImage = placeImageView.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placenameText.text!
                placeModel.placeType = placetypeText.text!
                placeModel.placeAtmo = placeatmosphereText.text!
                placeModel.placeImage = chosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        } else {
          makeAlert(titleInput: "Error", messageInput: "Place Name/Type/Atmosphere!")
        }
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
         let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
         let okBtn = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
         alert.addAction(okBtn)
         self.present(alert, animated: true, completion: nil)
         
     }
}
