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

    var dusunce = String()
    
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
        
        
        
        
        let alert = UIAlertController(title: "Düşünce ve Şikayet", message: "Eleştirebilirsiniz", preferredStyle: UIAlertController.Style.alert )
        //Step : 2
        let save = UIAlertAction(title: "Gönder", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if textField.text != "" {
                //Read TextFields text data
                print(textField.text!)
                self.dusunce = textField.text!
                self.dusunceGonder()
                
            } else {
                print("TF Boş...")
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Düşüncenizi Yazınız..."
            textField.textColor = .red
        }
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Vazgeç", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        self.present(alert, animated:true, completion: nil)

        
        
        
        
        
      
        
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
        alertFunction(message: "Kayıt olarak 18 yaşından büyük olduğunuzu kabul etmiş olursunuz. Bilgilerinizin gizliliği kimse tarafından tahrip edilemez. Uygulama tamamen anonim fikir paylaşımına izin vermektedir ve başka amaca hizmet edemez. Uygulama kullanımıyla ilgili çıkan ilişki değişikliklerinden tarafımız sorumlu değildir. Amaç sadece insanların birbirleri hakkında nasıl bir fikir yürüttükleridir. İnsanın kendisinin etrafı tarafından nasıl karşılandığını ortaya çıkaran bu uygulama aynı zamanda da sorumluluk kabul etmemektedir. Uygulama telif hakkı tasarımcısına yani Serkan Mehmet MALAGİÇ'e aittir. İzinsiz konseptin kullanılması yasaktır. Tüm soru ve görüşleriniz için serkanmalagic@icloud.com adresine mail atabilir veya sosyal medya hesaplarımdan benimle iletişime geçebilirsiniz.")
        
    }
    @IBAction func hakkimizdaButtonTapped(_ sender: Any) {

   
        //BUTON TIKLAMA EFEKTİ
        UIView.animate(withDuration: 0.1, animations: {
            self.hakkimizdaButton.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.hakkimizdaButton.transform = CGAffineTransform.identity
                })
        })
        alertFunction(message: "SerkanApp olarak 3 yıldan beri ios geliştirme üzerine çalışıyorum. Gerek profesyonel gerek ise amatör olarak çeşitli yazılımlar geliştiriyorum. Bilgisayar mühendisliği mezunuyum ve ios programlamayı çok seviyorum. Android veya diğer platformları da denedim fakat çok verim alamadım. Uygulamayı kullanırken geri bildirimleriniz benim için çok önemli mutlaka geri bildirim burakmayı unutmayın")
        
        
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
    
    
    
    
    func dusunceGonder(){
        
        self.showWaitOverlay()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            //json ile veritabanına kullanıcı id ve düşünce yazılacak
            // Kişinin özel bilgileri burada sergilenecek
            let json: [String: Any] = [
                "id":  UserDefaults.standard.string(forKey: "kullanici_id")!,
                "dusunce" : self.dusunce
            ]
            
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            // create post request
            let url = URL(string: base_url + "/kullanici/kullanici_dusunce.php")!
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
                        
                        let cevapValue                =  responseJSON["cevap"] as? String
                        
                        if cevapValue == "1"{
                            DispatchQueue.main.async {
                                self.removeAllOverlays()
                                self.alertFunction(message: "Düşünceniz Başarıyla Gönderilmiştir")
                            }
                            
                        }
                        else{
                            DispatchQueue.main.async {
                                self.removeAllOverlays()
                                self.alertFunction(message: "Bilinmeyen Bir Hata Oluştu")
                            }
                            
                        }
                        
                        
                        
                    }
                }
                task.resume()
            }
            
            
        }

        
        
        
    }
    
    
}
