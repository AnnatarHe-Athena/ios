//
//  PostDetailViewController.swift
//  athena-ios
//
//  Created by le.he on 2018/4/13.
//  Copyright © 2018 AnnatarHe. All rights reserved.
//

import UIKit
import SDWebImage

class PostDetailViewController : UIViewController {
    
    var data: FetchGirlsQueryQuery.Data.Girl? = nil
    
    @IBOutlet weak var fromUrl: UIButton!
    @IBOutlet weak var fromId: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBAction func doLike(_ sender: Any) {
        print("like")
    }
    @IBOutlet weak var collectBtn: UIButton!
    @IBAction func doCollect(_ sender: Any) {
        print("collect")
    }
    @IBAction func doDelete(_ sender: Any) {
        print("delete")
    }
    @IBAction func fromIdClicked(_ sender: Any) {
        self.showToast(message: "not support yet")
    }
    @IBAction func fromUrlClicked(_ sender: Any) {
        UIApplication.shared.open(URL(string: (self.data?.fromUrl)!)!, completionHandler: nil)
    }
    
    @objc func imageTapped() {
        Utils.presentBigPreview(
            view: self,
            src: self.data!,
            holderImage: self.imgView.image,
            from: self.view
        )
    }
    override func viewDidLoad() {
        // loaded
        self.title = data?.text
        self.textLabel.text = data?.text
        self.titleLabel.text = data?.text
        
        let imageSrc = Utils.getRealImageSrc(image: (data?.img)!)
        self.imgView.sd_setImage(with: URL(string: imageSrc), completed: nil)
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(PostDetailViewController.imageTapped))
        self.imgView.isUserInteractionEnabled = true
        self.imgView.addGestureRecognizer(singleTap)
        self.fromId.setTitle(data?.fromId, for: .normal)
        self.fromUrl.setTitle(data?.fromUrl, for: .normal)
    }
}
