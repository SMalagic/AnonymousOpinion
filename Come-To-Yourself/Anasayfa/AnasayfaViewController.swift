//
//  AnasayfaViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 10.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit

class AnasayfaViewController: UIViewController {

    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var uyeSayisiLabel: UILabel!
    @IBOutlet weak var degerlendirmeSayisiLabel: UILabel!
    
    @IBOutlet weak var kasKisiOyladiLabel: UILabel!
    @IBOutlet weak var ortalamanLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Futura", size: 20) ?? UIFont.systemFont(ofSize: 20)]

        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = true
       
   
    }
    
    @IBAction func segmentControl(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
             UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.view1.isHidden = false
                self.view2.isHidden = true
                self.view3.isHidden = true
            })
            
        case 1:
             UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.view1.isHidden = true
                self.view2.isHidden = false
                self.view3.isHidden = true
            })
        case 2:
             UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.view1.isHidden = true
                self.view2.isHidden = true
                self.view3.isHidden = false
            })
        default:
            break
        }
        
        
    }
    

}
