//
//  SecondViewController.swift
//  athena-ios
//
//  Created by AnnatarHe on 15/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import UIKit
import SDWebImage
import SDWebImageWebPCoder
import Sentry

class ProfileViewController: BaseViewController {
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var userCollectionsTableView: UICollectionView!
    @IBOutlet weak var profileContainer: UIView!
    
    var collections: [CellItem] = []
    
    var loadFrom = 0;
    var profileLoaded = false
    var loading = false
    
    private var collectionCursor = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userCollectionsTableView.dataSource = self
        userCollectionsTableView.delegate = self
        
        self.checkLogin()
    }
    
    @objc func touchAction(sender : UITapGestureRecognizer) {
        self.checkLogin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !profileLoaded && Config.token != "" {
            self.loadProfile()
        }
    }
    
    func checkLogin() {
        if Config.token == "" {
            performSegue(withIdentifier: "toAuth", sender: nil)
        }
    }
    
    func showAlert(err: Error?) {
        guard let msg = err?.localizedDescription else {
            // do nothing
            return
        }
        
        let alert = UIAlertController(title: "Load profile data error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        // sentry report this error
        self.present(alert, animated: true)
    }
    
    func loadProfile() {
        Config.getApolloClient().fetch(query: FetchProfileWithCollectionsQuery.init(id: Int(Config.userId)!, from: self.loadFrom, size: 20)) { result in
            self.collectionCursor += 20
            switch result {
            case .success(let resultData):
                var avatarUrl: String
                let userObj = resultData.data?.users!.fragments.profile
                self.title = userObj?.name!
                if userObj?.avatar == "null" {
                    avatarUrl = "https://via.placeholder.com/300x300"
                } else {
                    avatarUrl = (userObj?.avatar)!
                }
                
                let avatar = URL(string: avatarUrl)
                self.userAvatar.sd_setImage(with: avatar, placeholderImage: nil, options: .allowInvalidSSLCertificates, completed: nil)
                self.userName.text = userObj?.name
                self.userBio.text = userObj?.bio
                self.userEmail.text = userObj?.email
                
                resultData.data?.collections.flatMap {
                    $0.flatMap { c in
                        let cell = c?.fragments.fetchGirls
                        self.collections.append(
                            CellItem(
                                id:(cell?.id)!,
                                img: (cell?.img)!,
                                permission: (cell?.permission)!,
                                text: (cell?.text)!,
                                content: (cell?.content)!,
                                fromID: (cell?.fromId)!,
                                fromURL: (cell?.fromUrl)!
                            )
                        )
                    }
                }
//
//                let nc = resultData.data?.collections as! [FetchProfileWithCollectionsQuery.Data.Collection]
//                self.collections.append(contentsOf: nc)
//
                self.userCollectionsTableView.reloadData()
            case .failure(let err):
                self.showAlert(err: err)
            }
        }
    }
    
    func loadMoreCollect() {
        guard !loading else {
            return
        }
        loading = true
        
        Config.getApolloClient().fetch(query: FetchCollectionsQuery(id: Int(Config.userId)!, from: collectionCursor, size: 5)) { result in
            self.loading = false
            
            guard let newCollection = try? result.get().data?.collections else {
                print("error", result)
                return
            }
            
            if (newCollection.count == 0) {
                return
            }
            
            newCollection.flatMap { c in
                let cell = c?.fragments.fetchGirls
                self.collections.append(
                    CellItem(
                        id:(cell?.id)!,
                        img: (cell?.img)!,
                        permission: (cell?.permission)!,
                        text: (cell?.text)!,
                        content: (cell?.content)!,
                        fromID: (cell?.fromId)!,
                        fromURL: (cell?.fromUrl)!
                    )
                )
            }
//            let nc = newCollection as! [FetchProfileWithCollectionsQuery.Data.Collection]
            
//            self.collections.append(contentsOf: nc)
            
            self.userCollectionsTableView.reloadData()
            self.collectionCursor += 5
        }
    }
}

extension ProfileViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionGirlCell", for: indexPath) as! CollectionItemCellCollectionViewCell
        let dataItem = collections[indexPath.row]
        let img = Utils.getRealImageSrc(image: dataItem.img)
        
        print(img)
        cell.img.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "placeholderImage.png"), options: .allowInvalidSSLCertificates, completed: { _, err, _, _ in
//            print(err)
        })
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataCell = collectionView.cellForItem(at: indexPath) as! CollectionItemCellCollectionViewCell

        let dataItem = collections[indexPath.row] as! FetchProfileWithCollectionsQuery.Data.Collection
        
        Utils.presentBigPreview(
            view: self,
            imageUrl: dataItem.fragments.fetchGirls.img!,
            text: dataItem.fragments.fetchGirls.text!,
            holderImage: dataCell.img.image,
            from: dataCell
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print("will display", indexPath.item, collections.count)
        if (indexPath.item == collections.count - 1) {
            // load more
            print("profile load more")
            self.loadMoreCollect()
        }
    }
    
    
}
