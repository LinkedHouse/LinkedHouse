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
        self.navigationController?.navigationBar.isHidden = true;
        if(PFUser.current()?.object(forKey: "Intro") != nil){
            let Introduction = PFUser.current()?.object(forKey: "Intro") as! String
            IntroductionTextField.text = Introduction
            
        }
         else{
            IntroductionTextField.text = "Hello, nice to meet you!"
        }
        
        if(PFUser.current()?.object(forKey: "image") != nil){
            let imageFile = PFUser.current()?.object(forKey: "image")as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            self.profilePhotoImageView.af_setImage(withURL: url)
        }
        else{
            self.profilePhotoImageView.image = UIImage(named: "default user");
        }
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor,
                             right: view.rightAnchor, height: 300)
        view.addSubview(cancelButton)
               cancelButton.anchor(top: view.topAnchor, right: view.rightAnchor,
                                    paddingTop: 64, paddingRight: 32, width: 32, height: 32)
        view.addSubview(updateButton)
        updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateButton.anchor(top: profilePhotoImageView.bottomAnchor, paddingTop: 20)
    
        
        // Do any additional setup after loading the view.
    }
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPurple
        view.addSubview(profilePhotoImageView)
        profilePhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePhotoImageView.anchor(top: view.topAnchor, paddingTop: 88,
                                width: 120, height: 120)
        profilePhotoImageView.layer.cornerRadius = 120 / 2
        
        return view
    }()
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
         button.setImage(#imageLiteral(resourceName: "icons8-delete-50").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancel(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func handleCancel(sender: UIButton) {
        self.performSegue(withIdentifier: "cancel", sender: self)
    }
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update profile picture", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleUpdate(sender:)), for: .touchUpInside)
        return button
    }()
    @objc func handleUpdate(sender: UIButton) {
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
        if(profilePhotoImageView.image != nil){
              let imageData = profilePhotoImageView.image!.pngData()!
              let file = PFFileObject(name: "image.png", data: imageData)
              myuser.setObject(file, forKey: "image")
        }
              
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
