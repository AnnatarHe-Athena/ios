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
    
    @objc func imageTapped() {
        Utils.presentBigPreview(
            view: self,
            src: Utils.getRealImageSrc(image: (data?.img)!, type: "large"),
            holderImage: self.imgView.image,
            from: self.view
        )
    }
    override func viewDidLoad() {
        // loaded
        self.title = data?.text
        self.textLabel.text = data?.text
        
        let imageSrc = Utils.getRealImageSrc(image: (data?.img)!)
        self.imgView.sd_setImage(with: URL(string: imageSrc), completed: nil)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(PostDetailViewController.imageTapped))
        self.imgView.isUserInteractionEnabled = true
        self.imgView.addGestureRecognizer(singleTap)
    }
}
