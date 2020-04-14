//
//  EkleViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 10.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit

class EkleViewController: UIViewController , UISearchBarDelegate{

    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Kimin Hakkında..."
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        navigationItem.titleView = searchBar
        
        //DONE BUTTON KLAVYENİN ÜZERİNDEKİ GİZLEME BUTONU--->TÜM TEXTFİELDLAR
               var toolbar = UIToolbar()
               toolbar.sizeToFit()
               var flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
               var doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
               toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        searchBar.inputAccessoryView = toolbar

    }
    
    
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           
        searchBar.endEditing(true)
    print(searchBar.text)
       
    }
           

    @objc func doneClicked(){
           searchBar.endEditing(true)
       }
       

}
