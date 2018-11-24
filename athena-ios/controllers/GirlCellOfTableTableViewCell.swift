//
//  GirlCellOfTableTableViewCell.swift
//  athena-ios
//
//  Created by AnnatarHe on 02/10/2017.
//  Copyright © 2017 AnnatarHe. All rights reserved.
//

import UIKit

class GirlCellOfTableTableViewCell: UITableViewCell {
    
    var id = "-1"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var detailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        containerView.layer.cornerRadius = 0
        containerView.layer.masksToBounds = true
        
//        let squarePath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: 8).cgPath
//        self.containerView.layer.shadowPath = squarePath;
        
        self.detailImage.layer.cornerRadius = 0
        self.detailImage.layer.borderWidth = 1.0
        self.detailImage.layer.borderColor = UIColor.clear.cgColor
        self.detailImage.layer.masksToBounds = true
        
        self.containerView.layer.shadowColor = UIColor.lightGray.cgColor
        self.containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.containerView.layer.shadowRadius = 4.0
        self.containerView.layer.shadowOpacity = 0.8
        self.containerView.layer.masksToBounds = false
//        self.containerView.layer.shadowPath = UIBezierPath(roundedRect: self.containerView.bounds, cornerRadius: self.detailImage.layer.cornerRadius).cgPath
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
