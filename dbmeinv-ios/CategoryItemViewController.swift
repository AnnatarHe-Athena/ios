//
//  SecondViewController.swift
//  dbmeinv-ios
//
//  Created by 贺乐 on 02/03/2017.
//  Copyright © 2017 贺乐. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

struct Plato {
    let cate: Int
    let id: Int
    let img: String
    let text: String
}


class CategoryItemViewController: UITableViewController {
    
    private var isLoading = false
    
    private var selectedIndex: Int = 0
    private var offset: Int = 0
    var platos: [Plato?] = []
    var session: URLSession!
    
    
    let prefixer = "https://ww4.sinaimg.cn/bmiddle/"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.loadDataFromServer()
        title = "helle"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    public func setSelectedIndex(index: Int) {
        self.selectedIndex = index
    }
    
    func loadDataFromServer() {
        self.isLoading = true
        Alamofire.request("https://db.annatarhe.com/api/meinv/\(self.selectedIndex)/2/" + String(self.offset)).responseJSON{ response in
            if let result = response.result.value {
                if let datas = result as? [NSDictionary] {
                    for i in 0..<datas.count {
                        let cate = datas[i]["cate"]! as! Int
                        let id = datas[i]["id"]! as! Int
                        let img = datas[i]["img"]! as! String
                        let text = datas[i]["text"]! as! String
                        self.platos.append(Plato(cate: cate, id: id, img: img, text: text))
                    }
                    self.offset += 2
                    self.isLoading = false
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemImageCell", for: indexPath)
        if let img = platos[indexPath.row]?.img {
            let url = URL.init(string: self.prefixer + img)
            // load image from remote cdn server
            cell.imageView?.af_setImage(withURL: url!)
        } else {
            print("hello world")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platos.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.isLoading else {
            return
        }
        self.loadDataFromServer()
    }

}
