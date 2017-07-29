//
//  ProfileSectionViewController.swift
//  dbmeinv-ios
//
//  Created by AnnatarHe on 16/06/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import UIKit

class ProfileSectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func renderProfile() {
        let url = URL.init(string: (User.user?.avatarUrl)!)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, resp, err) -> Void in
            if err != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                
                let avatarView = self.storyboard?.instantiateViewController(withIdentifier: "profileAvatar") as! UIImageView
                avatarView.image = image
            })
        }).resume()
        
        let usernameView = self.storyboard?.instantiateViewController(withIdentifier: "profileUsername") as! UITextView
        usernameView.text = User.user?.username
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
