//
//  FirstViewController.swift
//  athena-ios
//
//  Created by AnnatarHe on 15/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import UIKit
import Apollo
import SDWebImage
import SKPhotoBrowser

class IndexViewController: UIViewController {
    @IBOutlet weak var cellListTableView: UITableView!
    
    private var categoryID: GraphQLID? = GraphQLID(0)
    private var cells: [FetchGirlsQueryQuery.Data.Girl?] = []
    
    private var loading: Bool = false

    @IBAction func CheckMore(_ sender: Any) {
        
        print(sender)
        let alert = UIAlertController(title: "Categories", message: nil, preferredStyle: .actionSheet)
        
        for var category in ModalApp.categories {
            alert.addAction(UIAlertAction(title: "category?.name", style: .default, handler: { action in
                
                self.categoryID = category?.id
                
                // load data
                self.loadCellsData()
                
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
        
        cellListTableView.dataSource = self
        cellListTableView.delegate = self
        
        initialLoad()
    }
    
    
    private func initialLoad() {
        Config.getApolloClient().fetch(query: InitCategoriesQuery()) { (result, err) in
            
            print(err ?? "")
            guard let categories = result?.data?.categories else {
                print("load incorrect data")
                print(result?.data)
                return
            }
            ModalApp.categories = categories
        }
    }
    
    private func loadCellsData(fetchMore: Bool = true) {
        guard !loading else {
            return
        }
        
        loading = true
        
        let offset = fetchMore ? cells.count : 0
        
        Config.getApolloClient().fetch(query: FetchGirlsQueryQuery(from: Int(self.categoryID!)!, take: 20, offset: offset)) { (result, err) in
            print(err ?? "")
            
            guard let girls = result?.data?.girls else {
                print("load error")
                return
            }
            
            if fetchMore {
                self.cells.append(contentsOf: girls)
                
            } else {
                self.cells = girls
            }
            
            self.cellListTableView.reloadData()
            self.loading = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension IndexViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GirlCell", for: indexPath) as? GirlCellOfTableTableViewCell else {
            fatalError("get cell fail")
        }
        
        let detail = cells[indexPath.row]
        
        let imageSrc = Utils.getRealImageSrc(image: (detail?.img)!)
        
        cell.detailImage.sd_setImage(with: URL(string: imageSrc), placeholderImage: UIImage(named: "placeholderImage.png"), options: .allowInvalidSSLCertificates, completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let itemData = cells[indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath) as! GirlCellOfTableTableViewCell
        
        let defaultImage = cell.detailImage.image
        
        Utils.presentBigPreview(view: self, src: Utils.getRealImageSrc(image: (itemData?.img)!, type: "large"), holderImage: defaultImage, from: cell)
        
        print("clicked", indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = cells.count - 1
        
        if indexPath.row == lastElement {
            // is last one
            // show load data
            self.loadCellsData(fetchMore: true)
            print("load more at footer")
        }
    }
}
