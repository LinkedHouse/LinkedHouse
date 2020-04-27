//
//  LoginViewController.swift
//  LinkedHouse
//
//  Created by angela on 4/18/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernamefield: UITextField!
    @IBOutlet weak var passwordfield: UITextField!
    @IBOutlet weak var errorfield: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignin(_ sender: Any) {
        let username = usernamefield.text!
               let password = passwordfield.text!
               
               PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                   if user != nil{
                       self.performSegue(withIdentifier: "loginSegue", sender: nil)
                   }
                   else{
                       self.errorfield.text = error?.localizedDescription
                       print("Error: \(error?.localizedDescription)")
                   }
               }
               

    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernamefield.text
        user.password = passwordfield.text
        user.signUpInBackground{(success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                self.errorfield.text = error?.localizedDescription
                print("Error: \(error?.localizedDescription)")
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
