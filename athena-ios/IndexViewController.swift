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
import SwiftUI

fileprivate let defaultCategoryID = GraphQLID(0)

fileprivate enum IndexCacheProgress: String {
    case category = "index:category"
    case offset = "index:offset"
}

class IndexViewController: BaseViewController {
    
    private let STEP = 20
    
    @IBAction func onSkipClick(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "⛷", message: "请输入最后一个的 id", preferredStyle: .alert)
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
            
            self.lastCellID = text
            self.noMore = false
            if self.cells.count > 0 {
                self.loadCellsData(fetchMore: true, cate: self.categoryID, isRandom: false)
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
    private var lastCellID = String(1 << 30)
    
    private var selectedItemIndex = 0
    
    private var loading: Bool = false
    @IBAction func CheckMore(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for var category in ModalApp.categories {
            alert.addAction(UIAlertAction(title: category?.name, style: .default, handler: { action in
                
                self.categoryID = category?.id
                self.title = category?.name
                self.noMore = false
                // load data
                self.loadCellsData(fetchMore: false, cate: self.categoryID)
                
                self.cellListTableView.setContentOffset(CGPoint.zero, animated: true)
                
                self.dismiss(animated: true, completion: nil)
            }))
        }
        
//        alert.addAction(UIAlertAction(title: "随机", style: .default, handler: {action in
//            // do random something
//            self.title = "随机"
//            // TODO: load random data
//            let randomIndex = Int(arc4random_uniform(UInt32(ModalApp.categories.count)))
//            let category = ModalApp.categories[randomIndex]
//            let cate = category?.id
//
//            let offset = Int(arc4random_uniform(UInt32((category?.count)!)))
//            print(cate, offset)
//            self.randomFetchCell(fetchMore: false)
//        }))
        
        alert.addAction(UIAlertAction(title: "refresh", style: .destructive, handler: { action in
            self.noMore = false
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
        cellListTableView.prefetchDataSource = self
        
        initialLoad()
        self.addRefrashControl()
    }
    
    private func addRefrashControl() {
        let refrashControl = UIRefreshControl()
        refrashControl.addTarget(self, action: #selector(self.pullToRefrash), for: .valueChanged)
        
        cellListTableView.refreshControl = refrashControl
    }
    
    @objc private func pullToRefrash() {
        if self.categoryID == defaultCategoryID {
            DispatchQueue.main.asyncAfter(deadline: .now() + 300) {
                DispatchQueue.main.async {
                    self.cellListTableView.refreshControl?.endRefreshing()
                }
            }
            self.showToast(message: "login first")
        }
        
        print("pull to refreash", self.lastCellID)
        Config.getApolloClient().fetch(
            query: FetchGirlsQueryQuery(from: Int(self.categoryID!)!, take: self.STEP, hideOnly: false, last: self.lastCellID)
        ) { result in
            
            self.cellListTableView.refreshControl?.endRefreshing()
            switch result {
            case .success(let resultData):
                let items = resultData.data?.girls
                if items!.count == 0 {
                    self.noMore = true
                    return
                }
                
                self.lastCellID = (items?.last??.fragments.fetchGirls.id)!
                self.cells = items!
                self.cellListTableView.reloadData()
            case .failure(let err):
                self.showAlert(err: err)
            }
        }
    }
    
    func initialLoad() {
        Config.getApolloClient().fetch(query: InitCategoriesQuery()) { result in
            guard let categories = try? result.get().data?.categories else {
                print("load incorrect data")
                let event = Event(level: .warning)
                event.message = "load incorrect data"
                event.extra = [
                    "error": try? result.get().errors
                ]
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
    
    private func loadCellsData(fetchMore: Bool = true, cate: GraphQLID?, theLastID: String = "", isRandom: Bool = false) {
        guard !loading else {
            return
        }
        
        loading = true
        
//        let newOffset = (fetchMore ? cells.count : offset) + self.skip
        
        let lastId = fetchMore ? self.lastCellID : String(1 << 30)
        Config.getApolloClient().fetch(
            query: FetchGirlsQueryQuery(from: Int(self.categoryID!)!, take: self.STEP, hideOnly: false, last: lastId)
        ) { result in
            
            switch result {
            case .success(let resultData):
                let dataItems = (resultData.data?.girls)!
                if dataItems.count == 0 {
                    self.noMore = true
                } else {
                    self.lastCellID = (dataItems.last??.fragments.fetchGirls.id)!
                }
                
                if fetchMore || isRandom {
                    self.cells.append(contentsOf: dataItems)
                } else {
                    self.cells = dataItems
                }
                UserDefaults.standard.set(Int(self.categoryID!), forKey: IndexCacheProgress.category.rawValue)
                self.cellListTableView.reloadData()
                self.loading = false
            case .failure(let err):
                self.showAlert(err: err)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y > 0) {
            // Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 0.35, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
//                self.navigationController?.setToolbarHidden(true, animated: true)
                print("Hide")
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 0.35, delay: 0, options: UIView.AnimationOptions(), animations: {
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
        
        self.selectedItemIndex = indexPath.row
        performSegue(withIdentifier: "imageDetail", sender: nil)
        // FIXME: fix me
//        let cellDataBefore = self.cells[indexPath.row]?.fragments.fetchGirls
//        let cellData = CellItem(
//            id: (cellDataBefore?.id)!,
//            img: (cellDataBefore?.img)!,
//            permission: (cellDataBefore?.permission)!,
//            text: (cellDataBefore?.text)!,
//            content: (cellDataBefore?.content)!,
//            fromID: (cellDataBefore?.fromId)!,
//            fromURL: (cellDataBefore?.fromUrl)!
//        )
//
//        let vc = UIHostingController(rootView: DetailView(cell: cellData))
//
//        self.navigationController?.show(vc, sender: nil)
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
            self.loadCellsData(fetchMore: true, cate: self.categoryID)
            print("load more at footer")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func toDelete(index: IndexPath) {
        let cell = self.cells[index.row]
        let cellID = cell?.fragments.fetchGirls.id
        
        self.cells.remove(at: index.row)
        self.cellListTableView.deleteRows(at: [index], with: .fade)
        Config.getApolloClient().perform(mutation: RemoveGirlMutation(cells: [Int(cellID!)], toRemove: false)) { result in
            
            if let err = try? result.get().errors {
                self.showToast(message: "😭 remove data error")
                
                self.cells.append(cell)
                self.cellListTableView.reloadRows(at: [IndexPath(row: self.cells.count - 1, section: 0)], with: .fade)
                return
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.toDelete(index: indexPath)
        }
    }
}

extension IndexViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.map { URL(string: Utils.getRealImageSrc(image: (self.cells[$0.row]?.fragments.fetchGirls.img)!))! }
        
        SDWebImagePrefetcher.shared.prefetchURLs(urls )
    }
}
