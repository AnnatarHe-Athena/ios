//
//  AuthViewController.swift
//  athena-ios
//
//  Created by AnnatarHe on 20/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var loading = false
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: Any) {

        if (self.loading) {
            return
        }

        guard let _email = email.text else {
            showErrorMsg(title: "email error")
            return
        }
        guard let _pwd = password.text else {
            showErrorMsg(title: "password error")
            return
        }
        indicator.startAnimating()

        Config.getApolloClient().fetch(query: AuthQuery(email: _email, password: _pwd)) { (result, err) in
            if (err != nil) {
                print(err)
                
                self.indicator.stopAnimating()
                self.loading = false
                return
            }

            guard let token = result?.data?.auth?.token else {
                print("token miss")
                
                self.indicator.stopAnimating()
                self.loading = false
                return
            }

            Config.token = token
            print(token)

            self.indicator.stopAnimating()
            self.loading = false
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func showErrorMsg(title: String) {
        let alert = UIAlertController(title: title, message: title, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        indicator.hidesWhenStopped = true
    }
}
