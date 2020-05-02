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
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 3
        shadowView.cornerRadius()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Dışarı basıldığında klavyeyi kapatır
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
    }
    
    @IBAction func gonderButtonTapped(_ sender: Any) {
        
        //BUTON TIKLAMA EFEKTİ
        UIView.animate(withDuration: 0.1, animations: {
            self.gonderButton.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.gonderButton.transform = CGAffineTransform.identity
                })
        })
        
        
        if mailText.text == ""{
            alertFunction(message: "Mail Boş Bırakılamaz")
        }
        else{
            //bu bölümde bahsi geçen mail adresine bir davetiye gönderilecek
            //web servise mail gönderme işlemleri yapılacak
            mailEkle()
            
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
    
    func mailEkle(){
        
        view.endEditing(true)

        if Reachability.isConnectedToNetwork(){
            if self.mailText.text == "" {
                self.alertFunction(message: "Lütfen Bilgileri Boş Bırakmayınız")
            }
            else{
                
                gonderButton.showLoading()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    
                    // prepare json data
                    let json: [String: Any] = [
                        "mail":  self.mailText.text!
                    ]
                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: json)
                    
                    // create post request
                    let url = URL(string: base_url + "/mail/mail_gonder.php")!
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

                                        _ = self.navigationController?.popToRootViewController(animated: true)
                                        self.gonderButton.hideLoading()
                                        self.alertLittle(title: "Mail Gönderildi", detail: "Umarız Aramıza Katılırlar")
                                        
                                        
                                    }
                                }
                                else if cevapValue == "0"{
                                    DispatchQueue.main.async {
                                        self.gonderButton.hideLoading()
                                        self.alertFunction(message: "Kullanıcı Adı veya Şifre Yanlış")
                                    }
                                }
                            }
                        }
                        task.resume()
                    }
                    
                }
            }
        }
        
    }
    
    

}
