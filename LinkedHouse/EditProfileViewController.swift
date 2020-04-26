//
//  EditProfileViewController.swift
//  LinkedHouse
//
//  Created by angela on 4/18/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var IntroductionTextField: UITextField!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let Introduction = PFUser.current()?.object(forKey: "Intro") as! String
        IntroductionTextField.text = Introduction
        if(PFUser.current()?.object(forKey: "image") != nil){
            let imageFile = PFUser.current()?.object(forKey: "image")as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            self.profilePhotoImageView.af_setImage(withURL: url)
        }

     
        
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectProfileButtonTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        profilePhotoImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
    
    @IBAction func SaveButtonTapped(_ sender: Any) {
        let myuser:PFUser = PFUser.current()!
               let introduction = IntroductionTextField.text
               let imageData = profilePhotoImageView.image!.pngData()!
               let file = PFFileObject(name: "image.png", data: imageData)
               myuser.setObject(file, forKey: "image")
               myuser.setObject(introduction, forKey: "Intro")
               myuser.saveInBackground{(success, error) in
                   if success{
                       print("saved!")
                       self.dismiss(animated: true, completion: nil)
                   }
                   else{
                       print("error!")
                   }
               }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
