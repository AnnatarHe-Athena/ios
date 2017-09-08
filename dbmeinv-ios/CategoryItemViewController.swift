//
//  SecondViewController.swift
//  dbmeinv-ios
//
//  Created by 贺乐 on 02/03/2017.
//  Copyright © 2017 贺乐. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class CategoryItemViewController: UITableViewController {
    private var isLoading = false
    private var navigationTitle = "详情页"
    
    private var selectedIndex: Int = 0
    private var offset: Int = 0
    var platos: [Plato?] = []
    
    private var lastTap: TimeInterval = 0.0
    private var lastIndexPath: IndexPath = []
    
    let prefixer = Config.imageBmiddleServer + "/"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.loadDataFromServer()
        title = navigationTitle
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    public func setSelectedIndex(index: Int) {
        self.selectedIndex = index
    }
    
    func loadDataFromServer() {
        // guard 取反
        guard !self.isLoading else {
            return
        }
        self.isLoading = true
//        Alamofire.request("\(Config.apiServer)/girls/\(self.selectedIndex)/2/" + String(self.offset)).responseJSON{ response in
//            if let result = response.result.value {
//                if let datas = result as? [NSDictionary] {
//                    for i in 0..<datas.count {
//                        let cate = datas[i]["cate"]! as! Int
//                        let id = datas[i]["id"]! as! Int
//                        let img = datas[i]["img"]! as! String
//                        let text = datas[i]["text"]! as! String
//                        self.platos.append(Plato(cate: cate, id: id, img: img, text: text))
//                    }
//                    self.offset = self.offset + 2
//                    self.isLoading = false
//                    self.tableView.reloadData()
//                }
//            }
//        }
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
//            cell.imageView?.af_setImage(withURL: url!)
//            URLSession.shared.dataTask(with: url!, completionHandler: { (data, resp, err) -> Void in
//                if err != nil {
//                    print(err!)
//                    return
//                }
//                DispatchQueue.main.async(execute: { () -> Void in
//                    let image = UIImage(data: data!)
//                    
//                    
//                    cell.imageView?.image = image
//                })
//            }).resume()
        } else {
            print("hello world")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platos.count
    }
    
    func setTitle(myTitle: String) -> Void {
        self.navigationTitle = myTitle
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let scrollViewHeight = bounds.size.height
        let currentOffset = offset.y + scrollViewHeight - inset.bottom
        let maxOffset = size.height
        
        let minSpace: CGFloat = 5
        let maxSpace: CGFloat = 10
        
        var shouldToLoad = false
        
        // 上拉刷新
        if scrollViewHeight >= maxOffset {
            let space = currentOffset - scrollViewHeight
            if space > minSpace && space < maxSpace {
                self.offset = 0
                shouldToLoad = true
            }
            
        } else {
            let space = currentOffset - maxOffset
            if space > minSpace && space < maxSpace {
                shouldToLoad = true
            }
        }
        
        if shouldToLoad {
            self.loadDataFromServer()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let now = Date().timeIntervalSince1970
        if (now - lastTap) < 0.3 && indexPath.elementsEqual(self.lastIndexPath) {
            print("double tap")
        }
        self.lastTap = now
        self.lastIndexPath = indexPath
    }

}
