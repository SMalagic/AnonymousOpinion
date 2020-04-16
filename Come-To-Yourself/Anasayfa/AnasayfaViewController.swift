//
//  AnasayfaViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 10.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit

class AnasayfaViewController: UIViewController {

    @IBOutlet weak var homeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        homeView.cornerRadius()
        homeView.dropShadow()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    


}
