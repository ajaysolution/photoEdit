//
//  ViewController.swift
//  photoEdit
//
//  Created by Ajay Vandra on 2/13/20.
//  Copyright © 2020 Ajay Vandra. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController , UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    @IBOutlet weak var imgView: UIImageView!
    
    var context : CIContext!
    var currentFilter : CIFilter!
    
    var currentImage : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        context = CIContext()
        currentFilter = CIFilter(name: "CIPhotoEffectNoir")
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        dismiss(animated: true)
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
       selectedImage()
    }
    @IBAction func filterButton(_ sender: UIButton) {
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        //image(imgView.image!, didFinishSavingWithError: nil, contextInfo : )
    }
    func selectedImage(){
        if let cgImage = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent){
            let processedImage = UIImage(cgImage: cgImage)
            imgView.image = processedImage
        }
    }
    @objc func image(_ image:UIImage, didFinishSavingWithError error : Error?,contextInfo : UnsafeRawPointer){
        if let error = error{
            let ac = UIAlertController(title: "save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default))}
            else{
                let ac = UIAlertController(title: "saved", message: "image is saved", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ok", style: .default))
                present(ac,animated: true)
            }
        }
    }


