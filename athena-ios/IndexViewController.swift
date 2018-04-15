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

class IndexViewController: UIViewController {
    @IBOutlet weak var cellListTableView: UITableView!
    
    private var categoryID: GraphQLID? = GraphQLID(0)
    private var cells: [FetchGirlsQueryQuery.Data.Girl?] = []
    private var noMore = false
    
    private var selectedItemIndex = 0
    
    private var loading: Bool = false
    @IBAction func CheckMore(_ sender: Any) {
        
        let alert = UIAlertController(title: "Categories", message: nil, preferredStyle: .actionSheet)
        
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
//            self.loadCellsData(fetchMore: false, cate: cate, offset: offset, isRandom: true)
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
        cell.id = (detail?.id)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let itemData = cells[indexPath.row]
//
//        let cell = tableView.cellForRow(at: indexPath) as! GirlCellOfTableTableViewCell
//
        self.selectedItemIndex = indexPath.row
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let postVC = storyboard.instantiateViewController(withIdentifier: "imageDetailView") as! PostDetailViewController
//        
//        postVC.data = itemData
        
        performSegue(withIdentifier: "imageDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageDetail" {
            let postVC = segue.destination as! PostDetailViewController
            postVC.data = cells[selectedItemIndex]
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.noMore {
            return
        }
        let lastElement = cells.count - 1
        
        
        if indexPath.row == lastElement {
            // is last one
            // show load data
            self.loadCellsData(fetchMore: true, cate: self.categoryID)
            print("load more at footer")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func toDelete(index: IndexPath) {
        
        let cell = self.cells[index.row]
        Config.getApolloClient().perform(mutation: RemoveGirlMutation(cells: [Int((cell?.id)!)], toRemove: false)) { (result, err) in
            if err != nil {
                self.showToast(message: "remove data error")
                return
            }
            
            self.cells.remove(at: index.row)
            self.cellListTableView.deleteRows(at: [index], with: .fade)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.toDelete(index: indexPath)
        }
    }
}
