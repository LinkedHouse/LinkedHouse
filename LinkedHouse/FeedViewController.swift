//
//  FeedViewController.swift
//  LinkedHouse
//
//  Created by angela on 4/18/20.
//  Copyright © 2020 angela. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.isHidden = false;
        tableView.delegate = self;
        tableView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        let query  = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20;
        
        query.findObjectsInBackground { (posts, error) in
            if(posts != nil){
                self.posts = posts!
                self.tableView.reloadData();
            }
            else{
                
            }
        }
    }
    
    var posts = [PFObject]();
    
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut();
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "loginViewController")
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row];
        let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username;
        cell.captionLabel.text = post["Description"] as! String
        print(post["Description"] as! String)
        
        let imageFile = post["Image"] as! PFFileObject
        let urlString = imageFile.url!
        
        let url = URL(string:urlString)!
        print(url);
        cell.photoView.af_setImage(withURL: url)
        
        return cell
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
