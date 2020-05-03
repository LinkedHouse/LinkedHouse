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
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        if(PFUser.current()?.object(forKey: "Intro") != nil){
            let Introduction = PFUser.current()?.object(forKey: "Intro") as! String
            IntroLabel.text = Introduction
        }
        if(PFUser.current()?.object(forKey: "image") != nil){
            let imageFile = PFUser.current()?.object(forKey: "image")as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            print(url)
            self.profileImageView.af_setImage(withURL: url)
        }
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor,
                             right: view.rightAnchor, height: 300)
        view.addSubview(editButton)
               editButton.anchor(top: view.topAnchor, right: view.rightAnchor,
                                    paddingTop: 64, paddingRight: 32, width: 32, height: 32)
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor,
                             paddingTop: 64, paddingLeft: 32, width: 32, height: 32)
        
       

        // Do any additional setup after loading the view.
    }
    lazy var containerView: UIView = {
           let view = UIView()
           view.backgroundColor = .mainPurple
           view.addSubview(profileImageView)
           profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           profileImageView.anchor(top: view.topAnchor, paddingTop: 88,
                                   width: 120, height: 120)
           profileImageView.layer.cornerRadius = 120 / 2
           view.addSubview(nameLabel)
                  nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                  nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
          
           return view
       }()
   
    let nameLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.text = PFUser.current()?.object(forKey: "username") as? String
           label.font = UIFont.boldSystemFont(ofSize: 26)
           label.textColor = .white
           return label
       }()
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "edit").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleEdit(sender:)), for: .touchUpInside)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icons8-back-50").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action:#selector(handleBack(sender:)), for: .touchUpInside)
        return button
    }()
   
    @objc func handleEdit(sender: UIButton) {
        self.performSegue(withIdentifier: "toEdit", sender: self)
    }
    @objc func handleBack(sender: UIButton) {
        self.performSegue(withIdentifier: "toHome", sender: self)
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
extension UIColor {
       static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
           return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
       }
       
       static let mainPurple = UIColor.rgb(red: 221, green: 160, blue: 221)
   }
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
                paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}


