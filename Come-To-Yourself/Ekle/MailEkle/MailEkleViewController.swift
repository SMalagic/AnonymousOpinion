//
//  MailEkleViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 25.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit

class MailEkleViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mailText: UITextField!
    
    @IBOutlet weak var gonderButton: LoadingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true


        //el ile gölgelendirme veriliyor
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOpacity = 0.6
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 5
        shadowView.cornerRadius()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Dışarı basıldığında klavyeyi kapatır
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        
    }
    
    @IBAction func gonderButtonTapped(_ sender: Any) {
        
        if mailText.text != ""{
            alertFunction(message: "Mail Boş Bırakılamaz")
        }
        else{
            //bu bölümde bahsi geçen mail adresine bir davetiye gönderilecek
            
        }
        
    }
    
    
    //Klavyeyi kapatan kod satırı
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    

}
