//
//  FirstViewController.swift
//  dbmeinv-ios
//
//  Created by 贺乐 on 02/03/2017.
//  Copyright © 2017 贺乐. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.requestAllCategroies()
    }
    
    func requestAllCategroies() {
        print("start request")
        Alamofire.request("https://db.annatarhe.com/api/meinv/categories").responseJSON { response in
            print("requst end")
            print(response.result.value!)
        }
        print("requesting")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

