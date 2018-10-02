//
//  SecondViewController.swift
//  athena-ios
//
//  Created by AnnatarHe on 15/09/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    //    @IBOutlet weak var userAvatar: UIImageView!
    //    @IBOutlet weak var userName: UILabel!
    //    @IBOutlet weak var userEmail: UILabel!
    //    @IBOutlet weak var userBio: UILabel!
    //    @IBOutlet weak var userCollectionsTableView: UITableView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var userCollectionsTableView: UICollectionView!
    @IBOutlet weak var profileContainer: UIView!
    
    var collections: [FetchProfileWithCollectionsQuery.Data.Collection?] = []
    
    var loadFrom = 0;
    var profileLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userCollectionsTableView.dataSource = self
        userCollectionsTableView.delegate = self
        
        self.checkLogin()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.touchAction))
        self.view.addGestureRecognizer(gesture)
        
    }
    
    
    @objc func touchAction(sender : UITapGestureRecognizer) {
        self.checkLogin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        // load profile
        Config.getApolloClient().fetch(query: FetchProfileWithCollectionsQuery(id: Int(Config.userId)!, from: self.loadFrom, size: 20)) { (result, err) in
            guard let user = result?.data?.users else {
                self.showAlert(err: err)
                return
            }
            let avatarUrl: String
            let userObj = user.fragments.profile
            if userObj.avatar == "null" {
                avatarUrl = "https://via.placeholder.com/300x300"
            } else {
                avatarUrl = userObj.avatar!
            }
            
            let avatar = URL(string: avatarUrl)
            self.userAvatar.sd_setImage(with: avatar, placeholderImage: nil, options: .allowInvalidSSLCertificates, completed: nil)
            self.userName.text = userObj.name
            self.userBio.text = userObj.bio
            self.userEmail.text = userObj.email
            // todo: collection
            if let collects = result?.data?.collections {
                self.collections = collects
                self.userCollectionsTableView.reloadData()
            }
            
            self.userAvatar.layer.cornerRadius = 40.0
            self.userAvatar.layer.borderWidth = 1.0
            self.userAvatar.layer.borderColor = UIColor.clear.cgColor
            self.userAvatar.layer.masksToBounds = true
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
        let img = Utils.getRealImageSrc(image: (dataItem?.fragments.fetchGirls.img!)!)
        
        cell.img.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "placeholderImage.png"), options: .allowInvalidSSLCertificates, completed: nil)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ffdjaksdjflasjdkf")
//        let dataCell = collectionView.cellForItem(at: indexPath) as! CollectionItemCellCollectionViewCell
//
//        let dataItem = collections[indexPath.row] as! FetchGirlsQueryQuery.Data.Girl
//        
//        Utils.presentBigPreview(
//            view: self,
//            src: dataItem,
//            holderImage: dataCell.img.image,
//            from: dataCell
//        )
    }
    
    
}
