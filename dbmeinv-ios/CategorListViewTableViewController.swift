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
        Alamofire.request("https://db.annatarhe.com/api/meinv/categories").responseJSON { response in
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
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
