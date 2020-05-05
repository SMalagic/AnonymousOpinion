//
//  AnasayfaViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 10.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import SwiftGifOrigin
import PopupDialog


class AnasayfaViewController: UIViewController {

    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var vview1: UIView!
    @IBOutlet weak var vview2: UIView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var vvview1: UIView!
    @IBOutlet weak var vvview2: UIView!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var siziNasilDegerlendirdimImageView: UIImageView!
    @IBOutlet weak var siziNasilDegerlendirdimButton: LoadingButton!
    
    
    @IBOutlet weak var uyeSayisiLabel: UILabel!
    @IBOutlet weak var degerlendirmeSayisiLabel: UILabel!
    
    @IBOutlet weak var kasKisiOyladiLabel: UILabel!
    @IBOutlet weak var ortalamanLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //apple gif görüntülenmesi
        let jeremyGif = UIImage.gif(name: "apple")
        siziNasilDegerlendirdimImageView.image = jeremyGif
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Futura", size: 20) ?? UIFont.systemFont(ofSize: 20)]

        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = true
        
        shadowAllViews()
        
        
        tumBilgileriGetir()
       
   
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
                self.view3.isHidden = true
                self.segmentedControl.setTitle("Çok Yakında", forSegmentAt: 2)
                
                //ELİMİZLE ALERT OLUŞTURDUK
                let title = "Profil Puanınıza Göre Sizi Yorumlayacağım. Sürpriz. Beklemede Kalın"
                let message = ""
                let popup = PopupDialog(title: title, message: message)
                popup.transitionStyle = .fadeIn
                let buttonOne = CancelButton(title: "Meraktayız") {
                    print("Tamam tuşuna basıldı.")
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                
                
            })
        default:
            break
        }
        
        
    }
    
    func shadowAllViews(){
        
        //el ile gölgelendirme veriliyor
        view1.layer.shadowColor = UIColor.black.cgColor
        view1.layer.shadowOpacity = 0.5
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowRadius = 3
        
        //el ile gölgelendirme veriliyor
        view2.layer.shadowColor = UIColor.black.cgColor
        view2.layer.shadowOpacity = 0.5
        view2.layer.shadowOffset = CGSize.zero
        view2.layer.shadowRadius = 3
        
        //el ile gölgelendirme veriliyor
        view3.layer.shadowColor = UIColor.black.cgColor
        view3.layer.shadowOpacity = 0.5
        view3.layer.shadowOffset = CGSize.zero
        view3.layer.shadowRadius = 3
        
        
        
        // VİEW İÇERİSİNDEKİLER RENKLENDİRİLİYOR
        
        //el ile gölgelendirme veriliyor
        vview1.layer.shadowColor = UIColor.darkGray.cgColor
        vview1.layer.shadowOpacity = 0.5
        vview1.layer.shadowOffset = CGSize.zero
        vview1.layer.shadowRadius = 3
        
        //el ile gölgelendirme veriliyor
        view.layer.shadowColor = UIColor.darkGray.cgColor
        vview2.layer.shadowOpacity = 0.5
        vview2.layer.shadowOffset = CGSize.zero
        vview2.layer.shadowRadius = 3
        
        //el ile gölgelendirme veriliyor
        vvview1.layer.shadowColor = UIColor.darkGray.cgColor
        vvview1.layer.shadowOpacity = 0.5
        vvview1.layer.shadowOffset = CGSize.zero
        vvview1.layer.shadowRadius = 3
        
        //el ile gölgelendirme veriliyor
        vvview2.layer.shadowColor = UIColor.darkGray.cgColor
        vvview2.layer.shadowOpacity = 0.5
        vvview2.layer.shadowOffset = CGSize.zero
        vvview2.layer.shadowRadius = 3
        
        
    }
    

    func tumBilgileriGetir(){
        
        
        //KULLANICIYA BEKLEMESİ SÖYLENECEK
        let alert = UIAlertController(title: nil, message: "Yükleniyor...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.bilgileriGetirJson()
        }
        
        
    }
    
    func bilgileriGetirJson(){
        
        DispatchQueue.main.async {
            
            // Kişinin özel bilgileri burada sergilenecek
            let json: [String: Any] = [
                "id":  UserDefaults.standard.string(forKey: "kullanici_id")!
            ]
            
            print(UserDefaults.standard.string(forKey: "kullanici_id"))
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            // create post request
            let url = URL(string: base_url + "/kullanici/kullanici_genel_bilgileri_getir.php")!
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
                        
                        let uyeSayisiValue              =  responseJSON["uyeSayisi"] as? String
                        let degerlendirmeSayisiValue    =  responseJSON["degerlendirmeSayisi"] as? String
                        let ortalamanValue              =  responseJSON["ortalaman"] as! Double
                        let kullaniciyaKacOyVerildiValue              =  responseJSON["kullaniciya_kac_oy_verildi"] as! String

                        print( uyeSayisiValue , degerlendirmeSayisiValue , ortalamanValue )
                        
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                            self.uyeSayisiLabel.text = uyeSayisiValue
                            self.degerlendirmeSayisiLabel.text = degerlendirmeSayisiValue
                            self.ortalamanLabel.text = "\(ortalamanValue)"
                            self.kasKisiOyladiLabel.text = kullaniciyaKacOyVerildiValue
                        }
                        
                        
                    }
                }
                task.resume()
            }
        }
        
    }
    
    @IBAction func siziNasiDegerlendirdimButtonTapped(_ sender: Any) {
        
        
        siziNasilDegerlendirdimButton.showLoading()
        // bu kısımda cümleler içerisinde seçim yapılacak ve seslendirilecek
        //BUTON TIKLAMA EFEKTİ
        UIView.animate(withDuration: 0.1, animations: {
            self.siziNasilDegerlendirdimButton.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.siziNasilDegerlendirdimButton.transform = CGAffineTransform.identity
                })
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.siziNasilDegerlendirdimButton.hideLoading()
        }
        
        
        
    }
    
    
        
}
