//
//  CategorListViewTableViewController.swift
//  dbmeinv-ios
//
//  Created by 贺乐 on 13/05/2017.
//  Copyright © 2017 贺乐. All rights reserved.
//

import UIKit
import Alamofire

struct CategoryItem {
    let id: Int
    let name: String
    let src: Int
}

class CategorListViewTableViewController: UITableViewController {
    
    var categories: [CategoryItem?] = []
    var selectedIndex: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.requestAllCategroies()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func requestAllCategroies() {
        Alamofire.request("\(Config.apiServer)/meinv/categories").responseJSON { response in
            if let result = response.result.value {
                if let categories = result as? [NSDictionary] {
                    for i in 0..<categories.count {
                        let id = categories[i]["id"]! as! Int
                        let name = categories[i]["name"]! as! String
                        let src = categories[i]["src"]! as! Int
                        self.categories.append(CategoryItem(id: id, name: name, src: src))
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categroyNameCell", for: indexPath)
        if let name = categories[indexPath.row]?.name {
            // TODO: 必须换成 name
            cell.textLabel?.text = name
        } else {
            cell.textLabel?.text = "nil"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = categories[indexPath.row]!.id
        performSegue(withIdentifier: "showCategoryItem", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showCategoryItem" else {
            return
        }
        let viewController = segue.destination as! CategoryItemViewController
        viewController.setSelectedIndex(index: self.selectedIndex)
        viewController.setTitle(myTitle: (categories[self.selectedIndex - 1]?.name)!)
    }
}
