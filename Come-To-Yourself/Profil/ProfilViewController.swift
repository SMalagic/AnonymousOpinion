//
//  ProfilViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 10.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import  PopupDialog
import StatusAlert
import GoogleMobileAds

class ProfilViewController: UIViewController, GADInterstitialDelegate{
    
    
   
    @IBOutlet weak var puanLabel: UILabel!
    @IBOutlet weak var adSoyadLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var shadowView1: UIView!
    @IBOutlet weak var shadowView2: UIView!
    @IBOutlet weak var shadowView3: UIView!
    
    @IBOutlet weak var sorunMuVarButton: UIButton!
    @IBOutlet weak var ilkelerimizButton: UIButton!
    @IBOutlet weak var hakkimizdaButton: UIButton!
    @IBOutlet weak var cikisYapButton: UIButton!
    
    var interstitial: GADInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        //reklam özellikleri---------------------
        createAndLoadInterstitial()
        interstitial.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            
            if self.interstitial.isReady {
              self.interstitial.present(fromRootViewController: self)
            } else {
              print("Ad wasn't ready")
            }
            
        }

        
        
        
        
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //MİNİK VERİTABANINDAN KULLANICI İD ÇEKİP SERVİSE GÖNDERİYORUZ
        let vt_kullanici_id : String  = UserDefaults.standard.string(forKey: "kullanici_adi")!
        
        shadowViews()
        profilBilgileriGetir()
        
    }
    
    @IBAction func sorunMuVarButtonTapped(_ sender: Any) {

        //BUTON TIKLAMA EFEKTİ
        UIView.animate(withDuration: 0.1, animations: {
            self.sorunMuVarButton.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.sorunMuVarButton.transform = CGAffineTransform.identity
                })
        })
        
        
        
        
      
        
    }
    @IBAction func ilkelerimizButtonTapped(_ sender: Any) {

        //BUTON TIKLAMA EFEKTİ
        UIView.animate(withDuration: 0.1, animations: {
            self.ilkelerimizButton.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.ilkelerimizButton.transform = CGAffineTransform.identity
                })
        })
    }
    @IBAction func hakkimizdaButtonTapped(_ sender: Any) {

        hakkimizdaButton.adjustsImageWhenHighlighted = false

        hakkimizdaButton.adjustsImageWhenDisabled = false
        //BUTON TIKLAMA EFEKTİ
        UIView.animate(withDuration: 0.1, animations: {
            self.hakkimizdaButton.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.hakkimizdaButton.transform = CGAffineTransform.identity
                })
        })
    }
    @IBAction func cikisYapButtonTapped(_ sender: Any) {
        
        //BUTON TIKLAMA EFEKTİ
        UIView.animate(withDuration: 0.1, animations: {
            self.cikisYapButton.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.cikisYapButton.transform = CGAffineTransform.identity
                })
        })

        let title = "Çıkış Yapılacak"
        let message = ""
        let popup = PopupDialog(title: title, message: message)
        popup.transitionStyle = .fadeIn
        let buttonOne = CancelButton(title: "Çıkış Yap") {
            
            //ÖNCE MİNİK VERİTABANINDAKİ VERİLERİ SİLİYORUZ
            UserDefaults.standard.removeObject(forKey: "kullanici_id")
            UserDefaults.standard.removeObject(forKey: "kullanici_adi")
            UserDefaults.standard.removeObject(forKey: "kullanici_sifre")
            UserDefaults.standard.removeObject(forKey: "kullanici_mail")
            UserDefaults.standard.synchronize()
            
            //ARDINDAN SEGUE İLE DİĞER EKRANA GEÇİYORUZ.
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "girisYapS") as! GirisYapViewController
            self.present(nextViewController, animated:true, completion:nil)
            
            let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            delegate.RememberUser()
            
            
            
        }
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
        
    }

    func shadowViews(){
        
        //el ile gölgelendirme veriliyor
        shadowView1.backgroundColor = UIColor.white
        shadowView1.layer.shadowColor = UIColor.gray.cgColor
        shadowView1.layer.shadowOpacity = 0.5
        shadowView1.layer.shadowOffset = CGSize.zero
        shadowView1.layer.shadowRadius = 3
        shadowView1.cornerRadius()
        
        //el ile gölgelendirme veriliyor
        shadowView2.backgroundColor = UIColor.white
        shadowView2.layer.shadowColor = UIColor.gray.cgColor
        shadowView2.layer.shadowOpacity = 0.5
        shadowView2.layer.shadowOffset = CGSize.zero
        shadowView2.layer.shadowRadius = 3
        shadowView2.cornerRadius()
        
        //el ile gölgelendirme veriliyor
        shadowView3.backgroundColor = UIColor.white
        shadowView3.layer.shadowColor = UIColor.gray.cgColor
        shadowView3.layer.shadowOpacity = 0.5
        shadowView3.layer.shadowOffset = CGSize.zero
        shadowView3.layer.shadowRadius = 3
        shadowView3.cornerRadius()
        
    }
    func profilBilgileriGetir(){
        
        //MİNİK VERİTABANINDAN KULLANICI İD ÇEKİP SERVİSE GÖNDERİYORUZ
        mailLabel.text =        UserDefaults.standard.string(forKey: "kullanici_mail")!
        adSoyadLabel.text =     UserDefaults.standard.string(forKey: "kullanici_adi")!
        
        //SUNUCUDAN GELECEK PUAN
        
        
        
        let json: [String: Any] = [
            "id":  UserDefaults.standard.string(forKey: "kullanici_id")!
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let url = URL(string: base_url + "/kullanici/kullanici_puan_getir.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                    
                    let puanValue =  responseJSON["puan"] as? String
                    
                    DispatchQueue.main.async {
                        
                        self.puanLabel.text = puanValue
                        
                    }
                    
                }
            }
            task.resume()
        }
        
        
        
        
        
        
        
        puanLabel.text =        UserDefaults.standard.string(forKey: "kullanici_puan")!
        
    }
    
    
    //reklam özellikleri---------------------------------------
    fileprivate func createAndLoadInterstitial() {
      interstitial = GADInterstitial(adUnitID: "ca-app-pub-5299893774436883/3400193654")
      let request = GADRequest()
      // Request test ads on devices you specify. Your test device ID is printed to the console when
      // an ad request is made.
      interstitial.load(request)
    }
    
    
    
    // reklam özellikleri -----------------------------------------------
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      print("Reklam Başarıyla Alındı")
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
      print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      print("Şu anda ekranda görünüyor")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("interstitialWillDismissScreen-------------")
    }

    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      print("Ekran Kapandı")
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("interstitialWillLeaveApplication-----------------")
    }
    
    
    
    
    
    
    
}
