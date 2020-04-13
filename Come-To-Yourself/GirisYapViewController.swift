//
//  GirisYapViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 8.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import PopupDialog

class GirisYapViewController: UIViewController {
    
    
    @IBOutlet weak var kullaniciMailText: UITextField!
    @IBOutlet weak var kullaniciSifreText: UITextField!
    @IBOutlet weak var girisYapButton: LoadingButton!
    
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
        
        girisYapButton.showLoading()
        
        // prepare json data
        let json: [String: Any] = [
            "mail":  kullaniciMailText.text!,
            "sifre": kullaniciSifreText.text!,
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "http://192.168.1.37:8888/cometoyourself/api/kullanici/kullanici_giris.php")!
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
                    
                    let cevapValue =  responseJSON["cevap"] as? String
                    if cevapValue == "1"{
                        DispatchQueue.main.async {
                            
                            self.alertFunction(message: "Mail Adresi Daha Önceden Alınmış")
                            kullanici_adi =         responseJSON["adsoyad"] as! String
                            kullanici_mail =        responseJSON["mail"] as! String
                            kullanici_sifre =       responseJSON["sifre"] as! String
                            kullanici_puan =        responseJSON["puan"] as! Int
                            kullanici_created_at =  responseJSON["created_at"] as! String
                            
                            self.girisYapButton.hideLoading()
                        }
                    }
                    else if cevapValue == "0"{
                        DispatchQueue.main.async {
                            self.girisYapButton.hideLoading()
                            self.alertFunction(message: "Kullanıcı Adı veya Şifre Yanlış")
                        }
                    }
                }
            }
            
            task.resume()
        }
        
        
        
        
        
        
    }
    
}
