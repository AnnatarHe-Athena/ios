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
import Sentry

fileprivate let defaultCategoryID = GraphQLID(0)

class IndexViewController: UIViewController {
    
    
    @IBOutlet weak var cellListTableView: UITableView!
    
    private var categoryID: GraphQLID? = defaultCategoryID
    private var cells: [FetchGirlsQueryQuery.Data.Girl?] = []
    private var noMore = false
    
    private var selectedItemIndex = 0
    
    private var loading: Bool = false
    @IBAction func CheckMore(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for var category in ModalApp.categories {
            alert.addAction(UIAlertAction(title: category?.name, style: .default, handler: { action in
                
                self.categoryID = category?.id
                self.title = category?.name
                // load data
                self.loadCellsData(fetchMore: false, cate: self.categoryID)
                
                self.cellListTableView.setContentOffset(CGPoint.zero, animated: true)
                
                self.dismiss(animated: true, completion: nil)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "随机", style: .default, handler: {action in
            // do random something
            self.title = "随机"
            // TODO: load random data
            let randomIndex = Int(arc4random_uniform(UInt32(ModalApp.categories.count)))
            let category = ModalApp.categories[randomIndex]
            let cate = category?.id
            
            let offset = Int(arc4random_uniform(UInt32((category?.count)!)))
            print(cate, offset)
            self.randomFetchCell(fetchMore: false)
        }))
        
        alert.addAction(UIAlertAction(title: "refresh", style: .destructive, handler: { action in
            self.initialLoad()
            self.dismiss(animated: true, completion: nil)
        }))
        
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
        
        self.addRefrashControl()
        
    }
    
    private func addRefrashControl() {
        let refrashControl = UIRefreshControl()
        refrashControl.addTarget(self, action: #selector(self.pullToRefrash), for: .valueChanged)
        
        cellListTableView.refreshControl = refrashControl
    }
    
    @objc private func pullToRefrash() {
        print("pull to refrash")
        if self.categoryID == defaultCategoryID {
            DispatchQueue.main.asyncAfter(deadline: .now() + 300) {
                DispatchQueue.main.async {
                    self.cellListTableView.refreshControl?.endRefreshing()
                }
            }
            self.showToast(message: "login first")
        }
        Config.getApolloClient().fetch(query: FetchGirlsQueryQuery(from: Int(self.categoryID!)!, take: 20, offset: 0, hideOnly: false)) { (result, err) in
            self.showAlert(err: err)
            guard let dataItems = result?.data?.girls else {
                print("load error")
                self.cellListTableView.refreshControl?.endRefreshing()
                return
            }
            
            if dataItems.count == 0 {
                self.noMore = true
            }
            
            self.cells = dataItems
            self.cellListTableView.reloadData()
            self.cellListTableView.refreshControl?.endRefreshing()
        }
    }
    
    func initialLoad() {
        Config.getApolloClient().fetch(query: InitCategoriesQuery()) { (result, err) in
            self.showAlert(err: err)
            guard let categories = result?.data?.categories else {
                print("load incorrect data")
                print(result?.data)
                
                let event = Event(level: .warning)
                event.message = "load incorrect data"
                Client.shared?.send(event: event, completion: nil)
                return
            }
            
            ModalApp.categories = categories
            
            if self.categoryID! == "0" {
                self.categoryID = categories.first??.id
                self.loadCellsData(fetchMore: false, cate: self.categoryID)
            }
        }
    }
    
    func showAlert(err: Error?) {
        guard let msg = err?.localizedDescription else {
            // do nothing
            return
        }
        
        let alert = UIAlertController(title: "Load Category data error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        // sentry report this error
        self.present(alert, animated: true)
    }
    
    private func loadCellsData(fetchMore: Bool = true, cate: GraphQLID?, offset: Int = 0, isRandom: Bool = false) {
        guard !loading else {
            return
        }
        
        loading = true
        
        let newOffset = fetchMore ? cells.count : offset
        
        Config.getApolloClient().fetch(query: FetchGirlsQueryQuery(from: Int(self.categoryID!)!, take: 20, offset: newOffset, hideOnly: false)) { (result, err) in
            self.showAlert(err: err)
            
            guard let dataItems = result?.data?.girls else {
                print("load error")
                return
            }
            
            if dataItems.count == 0 {
                self.noMore = true
            }
            
            if fetchMore || isRandom {
                self.cells.append(contentsOf: dataItems)
            } else {
                self.cells = dataItems
            }
            self.cellListTableView.reloadData()
            self.loading = false
        }
    }
    
    private func randomFetchCell(fetchMore: Bool = true) {
        guard !loading else {
            return
        }
        
        loading = true
        
        let randomIndex = Int(arc4random_uniform(UInt32(ModalApp.categories.count)))
        let category = ModalApp.categories[randomIndex]
        let cate = category?.id
        
        let offset = Int(arc4random_uniform(UInt32((category?.count)!)))
        
        Config.getApolloClient().fetch(query: FetchGirlsQueryQuery(from: Int(cate!)!, take: 20, offset: offset, hideOnly: false)) { (result, err) in
            self.showAlert(err: err)
            
            guard let dataItems = result?.data?.girls else {
                print("load error")
                self.showToast(message: "load data error")
                return
            }
            
            if dataItems.count == 0 {
                self.noMore = true
            }
            
            if fetchMore {
                self.cells.append(contentsOf: dataItems)
            } else {
                self.cells = dataItems
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
        
        let imageSrc = Utils.getRealImageSrc(image: (detail?.fragments.fetchGirls.img)!)
        
        cell.detailImage.sd_setImage(with: URL(string: imageSrc), placeholderImage: UIImage(named: "placeholderImage.png"), options: .allowInvalidSSLCertificates, completed: nil)
        cell.id = (detail?.fragments.fetchGirls.id)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let itemData = cells[indexPath.row]
        
        self.selectedItemIndex = indexPath.row
        
        performSegue(withIdentifier: "imageDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageDetail" {
            let postVC = segue.destination as! PostDetailViewController
            postVC.data = cells[selectedItemIndex]
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.noMore && self.title != "随机" {
            return
        }
        let lastElement = cells.count - 1
        
        if indexPath.row == lastElement {
            if self.title == "随机" {
                self.randomFetchCell(fetchMore: true)
            } else {
                self.loadCellsData(fetchMore: true, cate: self.categoryID)
            }
            print("load more at footer")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func toDelete(index: IndexPath) {
        let cell = self.cells[index.row]
        let cellID = cell?.fragments.fetchGirls.id
        Config.getApolloClient().perform(mutation: RemoveGirlMutation(cells: [Int(cellID!)], toRemove: false)) { (result, err) in
            if err != nil {
                self.showToast(message: "remove data error")
                return
            }
            
            self.cells.remove(at: index.row)
            self.cellListTableView.deleteRows(at: [index], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.toDelete(index: indexPath)
        }
    }
}
