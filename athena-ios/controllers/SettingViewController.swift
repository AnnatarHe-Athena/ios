//
//  SettingViewController.swift
//  athena-ios
//
//  Created by le.he on 2018/4/5.
//  Copyright © 2018 AnnatarHe. All rights reserved.
//

import UIKit
import SDWebImage

enum settingEnum {
    case about, logout, publicData, cache
}

struct SettingItem {
    var id: Int
    var title: String
    var type: settingEnum
}

class SettingViewController: UITableViewController {
    
    var settings = [
        SettingItem(id: 0, title: "👐 Open data", type: .publicData),
        SettingItem(id: 1, title: "👨‍💻 About", type: .about),
        SettingItem(id: 2, title: "🚪 Logout", type: .logout)
    ]
    
    override func viewDidLoad() {
        self.settings.append(SettingItem(id: 3, title: "🏬 cache size: \(SDImageCache.shared.totalDiskSize()) bytes", type: .cache))
        self.tableView.reloadData()
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
        
        switch settingData.type {
        case .about:
            performSegue(withIdentifier: "toAboutPage", sender: nil)
        case .publicData:
            performSegue(withIdentifier: "toPublicData", sender: nil)
        case .cache:
            SDImageCache.shared.clearDisk(onCompletion: {
                self.showToast(message: "cleared")
                self.settings[3].title = "🏬 cache size: 0"
                self.tableView.reloadData()
            })
            
        default:
            self.showToast(message: "not support yet")
            return
        }
        print("clicked", indexPath)
    }
}
