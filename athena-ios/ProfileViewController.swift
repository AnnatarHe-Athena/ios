//
//  SecondViewController.swift
//  athena-ios
//
//  Created by AnnatarHe on 15/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    //    @IBOutlet weak var userAvatar: UIImageView!
    //    @IBOutlet weak var userName: UILabel!
    //    @IBOutlet weak var userEmail: UILabel!
    //    @IBOutlet weak var userBio: UILabel!
    //    @IBOutlet weak var userCollectionsTableView: UITableView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var userCollectionsTableView: UITableView!
    
    var loadFrom = 0;
    var profileLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.checkLogin()
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.touchAction))
        self.view.addGestureRecognizer(gesture)
    }
    
    
    @objc func touchAction(sender : UITapGestureRecognizer) {
        self.checkLogin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !profileLoaded && Config.token != "" {
            self.loadProfile()
        }
    }
    
    func checkLogin() {
        if Config.token == "" {
            performSegue(withIdentifier: "toAuth", sender: nil)
        }
    }
    
    func showAlert(err: Error?) {
        guard let msg = err?.localizedDescription else {
            // do nothing
            return
        }
        
        let alert = UIAlertController(title: "Load profile data error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        // sentry report this error
        self.present(alert, animated: true)
    }
    
    func loadProfile() {
        // load profile
        Config.getApolloClient().fetch(query: FetchProfileWithCollectionsQuery(id: Int(Config.userId)!, from: self.loadFrom, size: 20)) { (result, err) in
            guard let user = result?.data?.users else {
                self.showAlert(err: err)
                return
            }
            let avatarUrl: String
            if user.avatar == "null" {
                avatarUrl = "https://via.placeholder.com/300x300"
            } else {
                avatarUrl = user.avatar!
            }
            
            //            self.userAvatar.sd_setImage(with: URL(string: "https://via.placeholder.com/300x300")!, completed: nil)
            let avatar = URL(string: avatarUrl)
            self.userAvatar.sd_setImage(with: avatar, placeholderImage: nil, options: .allowInvalidSSLCertificates, completed: nil)
            self.userName.text = user.name
            self.userBio.text = user.bio
            self.userEmail.text = user.email
            // todo: collection
        }
    }
}

