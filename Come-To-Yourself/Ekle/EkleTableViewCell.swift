//
//  EkleTableViewCell.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 16.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit

class EkleTableViewCell: UITableViewCell {

    @IBOutlet weak var kullaniciAdıLabel: UILabel!
    @IBOutlet weak var uyariLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
