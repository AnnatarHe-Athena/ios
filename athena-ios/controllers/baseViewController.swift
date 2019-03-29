//
//  baseViewController.swift
//  athena-ios
//
//  Created by le.he on 2019/2/1.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import Foundation
import UIKit


class BaseViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
}
