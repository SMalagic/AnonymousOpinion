//
//  PuanVerTableViewCell.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 16.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit

class PuanVerTableViewCell: UITableViewCell {

    @IBOutlet weak var soruLabel: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        btn1.startAnimatingPressActions()
//        btn2.startAnimatingPressActions()
//        btn3.startAnimatingPressActions()
//        btn4.startAnimatingPressActions()
//        btn5.startAnimatingPressActions()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
