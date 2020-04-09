//
//  KayitOlViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 8.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import FirebaseFirestore

class KayitOlViewController: UIViewController {

    @IBOutlet weak var adsoyadText: UITextField!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var sifreText: UITextField!
    @IBOutlet weak var sifreTekrarText: UITextField!
    @IBOutlet weak var kayitOlButton: LoadingButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Dışarı basıldığında klavyeyi kapatır
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
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
    
    @IBAction func kayitOlButtonTapped(_ sender: Any) {
        
        //İNTERNETE BAĞLI MI DEĞİL Mİ KONTROL EDİYORUZ
        if Reachability.isConnectedToNetwork(){
           if self.mailText.text == "" || self.sifreText.text == "" || self.sifreTekrarText.text == "" || adsoyadText.text == "" {
                       self.alertFunction(message: "Lütfen Bilgileri Boş Bırakmayınız")
           }
           else if sifreText.text != sifreTekrarText.text {
               self.alertFunction(message: "Şifreler birbiri ile uyuşmuyor")
               
               self.sifreTekrarText.text = ""
               self.sifreText.text       = ""
           }
           else
           {
               kayitOlButton.showLoading()
               DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                   self.kullaniciKontrol()
               }
           }
        }
        else{
            alertFunction(message: "İnternet Bağlantınızı Kontrol Ediniz")
        }
        
    }
    func kullaniciKontrol(){
        
        let db = Firestore.firestore()
        let docRef = db.collection("kullanici").whereField("mail", isEqualTo: mailText.text! ).limit(to: 1)
        docRef.getDocuments { (querysnapshot, error) in
            if error != nil {
                print("Document Error: ", error!)
            } else {
                if let doc = querysnapshot?.documents, !doc.isEmpty {
                    print("Veri Mevcut")
                    self.kayitOlButton.hideLoading()
                    self.alertFunction(message: "Mail ile kayıt olunmuş")
                    self.adsoyadText.text     = ""
                    self.mailText.text        = ""
                    self.sifreTekrarText.text = ""
                    self.sifreText.text       = ""
                    
                }
                else{
                    print("Veri Yok Alert Göster")
                    self.kullaniciKayit()
                }
            }
        }
    }
    func kullaniciKayit(){
        
        kayitOlButton.showLoading()
        view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            let fireStoreDatabase = Firestore.firestore()
            var fireStoreReference : DocumentReference? = nil
            let fireStoreKullanici = [ "ad" :   self.adsoyadText.text  ,
                                       "mail" : self.mailText.text!    ,
                                       "sifre": self.sifreText.text!   ,
                                       "puan":  0
                                     ] as [String : Any]

            fireStoreReference = fireStoreDatabase.collection("kullanici").addDocument(data: fireStoreKullanici, completion: { (error) in

                if error != nil{
                    self.alertFunction(message: "Hata :" + error!.localizedDescription)
                }
                else{
                    self.alertFunction(message: "Kayıt Olma İşlemi Başarılı")
                    self.kayitOlButton.hideLoading()
                }
            })
        }
        
    }
    
}
