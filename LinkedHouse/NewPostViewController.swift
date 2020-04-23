//
//  NewPostViewController.swift
//  LinkedHouse
//
//  Created by Gary Ouyang on 4/23/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var postimage: UIImageView!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postDescription: UITextField!
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func postButton(_ sender: Any) {
        let post = PFObject(className:"Posts")
        let imageData = postimage.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["Title"] = postTitle.text
        post["Image"] = file
        post["Description"] = postDescription.text
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print(error)
            }
        }
    }
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaled = image.af_imageScaled(to: size)
        
        postimage.image = scaled
        
        dismiss(animated: true, completion: nil)
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
