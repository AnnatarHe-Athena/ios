//
//  FirstViewController.swift
//  athena-ios
//
//  Created by AnnatarHe on 15/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {

    @IBAction func CheckMore(_ sender: Any) {
        let alert = UIAlertController(title: "Categories", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
            print(action)
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    private func initialLoad() {
        Config.getApolloClient().fetch(query: InitCategoriesQuery()) { (result, err) in
            
            print(err ?? "")
            print(result)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
