//
//  ProfileViewController.swift
//  LinkedHouse
//
//  Created by angela on 4/26/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var IntroLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let Introduction = PFUser.current()?.object(forKey: "Intro") as! String
        IntroLabel.text = Introduction
        if(PFUser.current()?.object(forKey: "image") != nil){
            let imageFile = PFUser.current()?.object(forKey: "image")as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            self.profileImageView.af_setImage(withURL: url)
        }

        // Do any additional setup after loading the view.
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
