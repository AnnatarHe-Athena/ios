//
//  PublicDataViewController.swift
//  athena-ios
//
//  Created by le.he on 2018/4/14.
//  Copyright © 2018 AnnatarHe. All rights reserved.
//

import UIKit

class PublicDataViewController: UIViewController {
    
    @IBOutlet weak var userCount: UILabel!
    @IBOutlet weak var cellCount: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var copyright: UILabel!
    override func viewDidLoad() {
        Config.getApolloClient().fetch(query: InfoQuery()) { (result, err) in
            if err != nil {
                print(err)
            }
            guard let info = result?.data?.info else {
                print("error", err)
                return
            }
            
            self.userCount.text = "server got \(info.userCount!) users"
            self.cellCount.text = "server got \(info.cellCount!) images"
            self.fee.text = "you have to pay \(info.fee!) if you want to login"
            self.email.text = "concat me with \(info.email!)"
            self.copyright.text = "copyright: \(info.copyright!)"
            
            self.runCardSequence(info: info)
        }
    }

    private func runCardSequence(info: InfoQuery.Data.Info) {
        let view = UIView()
        view.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        let text = UILabel()
        text.text = "server got \(info.userCount!) users"
        view.addSubview(text)
    }
    
}
