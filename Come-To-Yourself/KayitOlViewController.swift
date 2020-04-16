//
//  KayitOlViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 8.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import PopupDialog

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
           else if sifreText.text!.count < 8 {
                self.alertFunction(message: "Girilen Şifre 8 Karakterden Kısa Olamaz")
                self.sifreTekrarText.text = ""
                self.sifreText.text       = ""
           }
           else
           {
            
            self.kayitOlButton.showLoading()
            self.view.endEditing(true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.kullaniciKontrol()
            }

              
               
           }
        }
        else{
            alertFunction(message: "İnternet Bağlantınızı Kontrol Ediniz")
        }
        
    }
    func kullaniciKayit(){
        //post metoduyla karşı tarafa gönderilecek
        
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid

            // prepare json data
            let json: [String: Any] = ["adsoyad": adsoyadText.text!,
                                   "mail": mailText.text!,
                                   "sifre": sifreText.text!,
                                       "puan": 0
                                        ]

            let jsonData = try? JSONSerialization.data(withJSONObject: json)

            // create post request
            let url = URL(string: base_url + "/kullanici/kullanici_kayit.php")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            // insert json data to the request
            request.httpBody = jsonData

        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                    let cevapValue = responseJSON["cevap"] as! String
                    
                    if cevapValue == "1" {
                        DispatchQueue.main.async {
                            let title = "Uyarı Penceresi"
                            let message = "Kayıt İşlemi Başarılı Lütfen Giriş Yapın"
                            let popup = PopupDialog(title: title, message: message)
                            popup.transitionStyle = .fadeIn
                            let buttonOne = CancelButton(title: "Giriş Yap") {
                                self.performSegue(withIdentifier: "toGirisYapSegue", sender: nil)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                        
                    }
                    else{
                        self.alertFunction(message: "Kullanıcı mevcut")
                    }
                }
            }

            task.resume()
        }
        
            
        
        
        
       
    }
    func kullaniciKontrol(){
        
        DispatchQueue.main.async {
            
            //PHP DOSYASINA GÖNDERİLECEK URL OLUŞTURULUYOR
                        let myUrl = URL(string: base_url + "/kullanici/kullanici_kontrol.php?mail=" + self.mailText.text! );
                        
                        var request = URLRequest(url:myUrl!)
                        request.httpMethod = "GET"// Compose a query string
                                
                        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                            if error != nil
                            {
                                print("error=\(error)")
                                return
                            }
                            //Let's convert response sent from a server side script to a NSDictionary object:
                            do {
                                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                
                                if let parseJSON = json {
                                    
                                    print(json)
                                    //WEB SERSİVİNDEN DÖNEN HASH VE SUCCESS DEĞERLERİ BURADAN ALINIP MAİL OLARAK GÖNDERİLECEK
                                    let cevapValue =  parseJSON["cevap"] as? String
            
                                    if cevapValue == "1"{
                                        DispatchQueue.main.async {
            
                                            self.alertFunction(message: "Mail Adresi Daha Önceden Alınmış")
            
                                            kullanici_mail =  parseJSON["mail"] as! String
                                            kullanici_adi =  parseJSON["adsoyad"] as! String
                                            kullanici_created_at =  parseJSON["created_at"] as! String
            
                                            self.kayitOlButton.hideLoading()
                                        }
                                    }
                                    else{
                                        DispatchQueue.main.async {
                                            self.kayitOlButton.hideLoading()
                                            self.kullaniciKayit()
                                        }
                                    }
                                  
                                }
                            } catch {
                                print(error)
                            }
                        }
                        task.resume()
        }
            
        
        
    }
    
}
