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
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}