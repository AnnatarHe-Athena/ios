//
//  PostDetailViewController.swift
//  athena-ios
//
//  Created by le.he on 2018/4/13.
//  Copyright © 2018 AnnatarHe. All rights reserved.
//

import UIKit
import SDWebImage

class PostDetailViewController : BaseViewController {
    
    var data: FetchGirlsQueryQuery.Data.Girl? = nil
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fromUrl: UIButton!
    @IBOutlet weak var fromId: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imageHeighConstrant: NSLayoutConstraint!
    @IBAction func fromIdClicked(_ sender: Any) {
        let isWeibo = (self.data?.fragments.fetchGirls.fromUrl?.contains("https://weibo.com"))!
        let isJike = (self.data?.fragments.fetchGirls.fromUrl?.contains("https://web.okjike.com"))!
        guard isWeibo || isJike else {
            self.showToast(message: "not support yet")
            return
        }
        var url: URL = URL(string: "https://db.annatarhe.com")!
        
        if isWeibo {
            let urlScheme = "sinaweibo://userinfo?uid=\(data?.fragments.fetchGirls.fromId! ?? "0")"
            url = URL(string: urlScheme)!
        }
        
        if isJike {
            let userURL = URL(string: (self.data?.fragments.fetchGirls.fromId)!)
            let paths = userURL?.path.split(separator: "/")
            let userID = String(paths![paths!.count - 1])
            url = URL(string: "jike://page.jk/user/\(userID)")!
        }
        
        if !UIApplication.shared.canOpenURL(url) {
            self.showToast(message: "not support yet")
            return
        }
        UIApplication.shared.open(url, completionHandler: nil)
    }
    @IBAction func fromUrlClicked(_ sender: Any) {
        let fromUrl = self.data?.fragments.fetchGirls.fromUrl
        
        let urlScheme = Utils.getURLScheme(url: fromUrl!)
        var url = URL(string: urlScheme)
        if !UIApplication.shared.canOpenURL(URL(string: urlScheme)!) {
            url = URL(string: fromUrl!)
        }
        
        UIApplication.shared.open(url!, completionHandler: nil)
    }
    
    override func awakeFromNib() {
        
//        self.imgView.layer.cornerRadius = 4.0
//        self.imgView.layer.borderWidth = 1.0
//        self.imgView.layer.borderColor = UIColor.clear.cgColor
    }
    
    @objc func imageTapped() {
        Utils.presentBigPreview(
            view: self,
            imageUrl: (self.data?.fragments.fetchGirls.img!)!,
            text: (self.data?.fragments.fetchGirls.text)!,
            holderImage: self.imgView.image,
            from: self.view
        )
    }
    override func viewDidLoad() {
        
        // display navigation bar if it is hidden
        if self.navigationController?.isNavigationBarHidden ?? false {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            print("Unhide")
        }
        
        // loaded
        let postDetail = data?.fragments.fetchGirls
        self.title = postDetail!.text
        self.textLabel.text = postDetail!.content
        self.titleLabel.text = postDetail!.text
        
        let imageSrc = Utils.getRealImageSrc(image: (postDetail!.img)!)
        self.imgView.sd_setImage(with: URL(string: imageSrc), completed: {(image, error, cacheType, imageURL) in
            let rate = (image?.size.width)! / (image?.size.height)!
            let height = (UIScreen.main.bounds.width - 16) / rate
            self.imageHeighConstrant.constant = height
            self.updateViewConstraints()
        })
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(PostDetailViewController.imageTapped))
        self.imgView.isUserInteractionEnabled = true
        self.imgView.addGestureRecognizer(singleTap)
        self.fromId.setTitle(postDetail!.fromId, for: .normal)
        self.fromUrl.setTitle(postDetail!.fromUrl, for: .normal)
        
        let rightBtn = UIBarButtonItem(title: "Actions", style: .plain, target: self, action: #selector(self.onRightBtnClicked))
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    @objc private func onRightBtnClicked() {
        let actionsSheets = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionsSheets.addAction(UIAlertAction(title: "❤️ Like", style: .default, handler: { action in
            self.showToast(message: "like not support yet")
        }))
        actionsSheets.addAction(UIAlertAction(title: "📖 Collect", style: .default, handler: { action in
            print("do Collect action")
            let cellID = Int((self.data?.fragments.fetchGirls.id!)!)
            
            Config.getApolloClient()
                .perform(mutation: AddToCollectionMutation(cells: [cellID])) { result in
                    
                    switch result {
                    case .success(let result):
                        self.showToast(message: "😁 collection saved")
                    case .failure(let error):
                        print(error)
                        self.showToast(message: "😭 remove data error")
                    }
            }
        }))
        actionsSheets.addAction(UIAlertAction(title: "Like", style: .destructive, handler: { action in
            print("do Delete action")
            self.showToast(message: "😭 delete not support yet")
        }))
        actionsSheets.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsSheets, animated: true, completion: nil)
    }
}
