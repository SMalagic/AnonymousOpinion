//
//  GirisYapViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 8.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import FirebaseFirestore

class GirisYapViewController: UIViewController {

    
    @IBOutlet weak var kullaniciMailText: UITextField!
    @IBOutlet weak var kullaniciSifreText: UITextField!
    @IBOutlet weak var girisYapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Dışarı basıldığında klavyeyi kapatır
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
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
    
    
    @IBAction func girisYapButtonTapped(_ sender: Any) {
        
        //İNTERNETE BAĞLI MI DEĞİL Mİ KONTROL EDİYORUZ
               if Reachability.isConnectedToNetwork(){
                  if self.kullaniciMailText.text == "" || self.kullaniciSifreText.text == ""{
                     self.alertFunction(message: "Lütfen Bilgileri Boş Bırakmayınız")
                  }
                  else
                  {
                     //gelen bilgilerin alındığı yer
                    
                    
                   }
                
                }
        
        let db = Firestore.firestore()
        let docRef = db.collection("kullanici").whereField("mail", isEqualTo: "a@b").getDocuments { (snapshot, error) in
            if error != nil {
                self.alertFunction(message: "Bilinmeyen Bir Hata Oluştu. Tekrar Deneyiniz")
            }
            else{
                
                for document in (snapshot?.documents)! {
                    kullanici_mail = document.data()["mail"] as! String
                    kullanici_sifre = document.data()["sifre"] as! String
                    kullanici_puan = document.data()["puan"] as! Int
                    kullanici_adi = document.data()["ad"] as! String

                    print("Kullanıcının Mail : \(kullanici_mail)  Kullanıcı Sifre :  \(kullanici_sifre) Kullanıcı Puan : \(kullanici_puan) Kullanici Adı : \(kullanici_adi)")
                }
                
            }
        }

        
    }
    
}
