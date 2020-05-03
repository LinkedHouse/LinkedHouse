//
//  FeedViewController.swift
//  LinkedHouse
//
//  Created by angela on 4/18/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.isHidden = false;

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut();
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "loginViewController")
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
        print("hello")
    }
    
    
    // this is a commit test
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
