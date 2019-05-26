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

fileprivate enum IndexCacheProgress: String {
    case category = "index:category"
    case offset = "index:offset"
}

class IndexViewController: BaseViewController {
    
    @IBAction func onSkipClick(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "跳过", message: "请输入跳过数量", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
            textField.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "submit", style: .default, handler: { action in
            let text = alert.textFields![0].text!
            guard !text.isEmpty else {
                self.showToast(message: "no data")
                return
            }
            
            let _skip = Int(text)
            
            self.skip = _skip!
            
            if self.cells.count > 0 {
                self.loadCellsData(fetchMore: true, cate: self.categoryID, offset: 0, isRandom: false)
            }
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true)
    }
    
    @IBOutlet weak var cellListTableView: UITableView!
    
    private var categoryID: GraphQLID? = defaultCategoryID
    private var cells: [FetchGirlsQueryQuery.Data.Girl?] = []
    private var noMore = false
    private var skip = 0
    
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
        
        cellListTableView.dataSource = self
        cellListTableView.delegate = self
        
        let _category = UserDefaults.standard.integer(forKey: IndexCacheProgress.category.rawValue)
        let _offset = UserDefaults.standard.integer(forKey: IndexCacheProgress.offset.rawValue)
        
        if _category != 0 && _offset != 0 {
            
            let refreshAlert = UIAlertController(title: "继续？", message: "监测到上次有未完成的进度，是否继续", preferredStyle: .alert)
            refreshAlert.addAction(UIAlertAction(title: "继续", style: .default, handler: { (action: UIAlertAction!) in
                self.categoryID = GraphQLID(_category)
                // TODO: update offset
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action: UIAlertAction!) in
                self.initialLoad()
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        
        } else {
            initialLoad()
        }
        
        
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
        Config.getApolloClient().fetch(query: FetchGirlsQueryQuery(from: Int(self.categoryID!)!, take: 20, offset: self.skip, hideOnly: false)) { (result, err) in
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
        
        let newOffset = (fetchMore ? cells.count : offset) + self.skip
        
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
            UserDefaults.standard.set(Int(self.categoryID!), forKey: IndexCacheProgress.category.rawValue)
            UserDefaults.standard.set(offset, forKey: IndexCacheProgress.offset.rawValue)
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
                self.showToast(message: "😭 load data error")
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
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y > 0) {
            // Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
//                self.navigationController?.setToolbarHidden(true, animated: true)
                print("Hide")
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
//                self.navigationController?.setToolbarHidden(false, animated: true)
                print("Unhide")
            }, completion: nil)
        }
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
        
        cell.detailImage.sd_setImage(with: URL(string: imageSrc), placeholderImage: nil, options: .allowInvalidSSLCertificates, completed: nil)
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
                self.showToast(message: "😭 remove data error")
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
