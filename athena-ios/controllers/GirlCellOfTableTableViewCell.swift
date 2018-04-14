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
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBAction func likeBtn(_ sender: Any) {
        print("like ", id)
    }
    @IBAction func collectBtn(_ sender: Any) {
        print("collect", id)
    }
    @IBAction func deleteBtnTapped(_ sender: Any) {
        print("remove item", id)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
