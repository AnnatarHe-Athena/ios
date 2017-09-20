//
//  FirstViewController.swift
//  athena-ios
//
//  Created by AnnatarHe on 15/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import UIKit
import Apollo

class IndexViewController: UIViewController {
    
    private var categoryID: GraphQLID? = GraphQLID(0)

    @IBAction func CheckMore(_ sender: Any) {
        
        print(sender)
        let alert = UIAlertController(title: "Categories", message: nil, preferredStyle: .actionSheet)
        
        for var category in ModalApp.categories {
            alert.addAction(UIAlertAction(title: category?.name, style: .default, handler: { action in
                
                self.categoryID = category?.id
                
                self.dismiss(animated: true, completion: nil)
            }))
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initialLoad()
    }
    
    
    private func initialLoad() {
        Config.getApolloClient().fetch(query: InitCategoriesQuery()) { (result, err) in
            
            print(err ?? "")
            guard let categories = result?.data?.categories else {
                print(" load incorrect data")
                return
            }
            ModalApp.categories = categories
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
