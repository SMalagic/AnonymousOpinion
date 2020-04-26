//
//  EkleViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 10.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import PopupDialog



class EkleViewController: UIViewController , UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        searchBar.showsCancelButton = false
    
        searchBar.placeholder = "e-posta veya isim..."
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.prefersLargeTitles = true

        
        //DONE BUTTON KLAVYENİN ÜZERİNDEKİ GİZLEME BUTONU--->TÜM TEXTFİELDLAR
        var toolbar = UIToolbar()
        toolbar.sizeToFit()
        var flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        var doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        searchBar.inputAccessoryView = toolbar
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        if searchBar.text != ""{
            
            searchBar.endEditing(true)
            print(searchBar.text)
            
            
            //KULLANICIYA BEKLEMESİ SÖYLENECEK
            let alert = UIAlertController(title: nil, message: "Kişi Bulunuyor...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismiss(animated: true, completion: nil)
                self.kullaniciBul()
            }
            
        }
        else{
            alertFunction(message: "Arama Bölümü Boş Bırakılamaz")
        }
        
        
        
        
    }
    
    func kullaniciBul(){
        //veritabanında bu ismi içerenleri anlık olarak getirir
        
        DispatchQueue.main.async {
            
            // prepare json data
            let json: [String: Any] = [
                "adsoyad":  self.searchBar.text!,
            ]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            // create post request
            let url = URL(string: base_url + "/kullanici/kullanici_bul.php")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // insert json data to the request
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                DispatchQueue.main.async {
                    
                    if let error = error  {
                        print("Hata")
                        self.alertFunction(message: "Geçersiz İstek. Bilinmeyen Hata")
                        return
                    }
                    guard let data = data else {return}
                    do{
                        let decoder = JSONDecoder()
                        kullanicilarJson = try decoder.decode([Kullanici].self, from: data)
                        print(kullanicilarJson)

                        if kullanicilarJson[0].id == "boş" {
                            
                            kullanicilarJson.removeAll()
                            self.tableView.reloadData()
                            
                            //ALERT BÖLÜMÜ------------------
                            let title = "Bulunamadı. Belki de Üye Değildir. Hemen Eklemek İstediğin Arkadaşının Mail Adresini Buraya Gir. Merak Etme Haberi Olmayacak"
                            let message = ""
                            let popup = PopupDialog(title: title, message: message)
                            popup.transitionStyle = .fadeIn
                            let buttonOne = CancelButton(title: "Tamam") {
                                
                                self.performSegue(withIdentifier: "toMailSegue", sender: nil)
                                
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                            
                        }
                        self.tableView.reloadData()
                    }
                    catch let jsonError{
                        print("Fail", jsonError)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if kullanicilarJson.count == 0 {
            self.tableView.setEmptyMessage("Kişilerinizi Arayın ve Puan Verin")
        } else {
            self.tableView.restore()
        }
        
        return kullanicilarJson.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KullaniciCell") as! EkleTableViewCell
        
        cell.kullaniciAdıLabel.text = kullanicilarJson[indexPath.row].adsoyad.uppercased()
        
        //el ile gölgelendirme veriliyor
        cell.shadowView.backgroundColor = UIColor.white
        cell.shadowView.layer.shadowColor = UIColor.gray.cgColor
        cell.shadowView.layer.shadowOpacity = 0.6
        cell.shadowView.layer.shadowOffset = CGSize.zero
        cell.shadowView.layer.shadowRadius = 5
        cell.shadowView.cornerRadius()
        
        //SEÇİM YAPILACAK HÜCRENİN ARKA PLAN RENGİNİ AYARLIYORUZ.
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Seçilen Kullanıcı id : " + kullanicilarJson[indexPath.row].id)
        secilen_kullanici_id = kullanicilarJson[indexPath.row].id
        
        performSegue(withIdentifier: "toPuanVerSegue", sender: nil)
        
    }
    
    
    @objc func doneClicked(){
        searchBar.endEditing(true)
    }
    
    
    
}
