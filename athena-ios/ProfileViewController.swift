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

}

