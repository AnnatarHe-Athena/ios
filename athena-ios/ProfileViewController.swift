//
//  SecondViewController.swift
//  athena-ios
//
//  Created by AnnatarHe on 15/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var userCollectionsTableView: UITableView!
    
    var loadFrom = 0;
    
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
        Config.getApolloClient().fetch(query: FetchProfileWithCollectionsQuery(id: 1, from: self.loadFrom, size: 20)) { (result, err) in
            guard let user = result?.data?.users else {
                self.showAlert(err: err)
                return
            }
            
            self.userAvatar.sd_setImage(with: URL(string: user.avatar!)!, completed: nil)
            self.userName.text = user.name
            self.userBio.text = user.bio
            
            // todo: collection
            
        }
    }

}

