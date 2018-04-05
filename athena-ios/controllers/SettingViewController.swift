//
//  SettingViewController.swift
//  athena-ios
//
//  Created by le.he on 2018/4/5.
//  Copyright © 2018 AnnatarHe. All rights reserved.
//

import UIKit

enum settingEnum {
    case about, logout, publicData
}

struct SettingItem {
    var id: Int
    var title: String
    var type: settingEnum
}

class SettingViewController: UITableViewController {
    
    let settings = [
        SettingItem(id: 0, title: "public data", type: .publicData),
        SettingItem(id: 1, title: "About", type: .about),
        SettingItem(id: 2, title: "Logout", type: .logout)
    ]
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCellItem", for: indexPath) as? SettingCell else {
            fatalError("get cell fail")
        }
        
        let detail = settings[indexPath.row]
        
        cell.textLabel?.text = detail.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let settingData = self.settings[indexPath.row]
        
        if settingData.type == .about {
            performSegue(withIdentifier: "toAboutPage", sender: nil)
        }
        print("clicked", indexPath)
    }
}
