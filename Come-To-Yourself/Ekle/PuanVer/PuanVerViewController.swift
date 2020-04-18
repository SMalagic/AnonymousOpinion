//
//  PuanVerViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 16.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import SCLAlertView

class PuanVerViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var puanVerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var closeImgView: UIImageView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
           closeImgView.isUserInteractionEnabled = true
           closeImgView.addGestureRecognizer(tapGestureRecognizer)
        
        
        setupButtons()
        
        //view işlemleri
        puanVerView.isHidden = true
        puanVerView.backgroundColor = UIColor.white
        puanVerView.layer.shadowColor = UIColor.gray.cgColor
        puanVerView.layer.shadowOpacity = 0.6
        puanVerView.layer.shadowOffset = CGSize.zero
        puanVerView.layer.shadowRadius = 5
        puanVerView.cornerRadius()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "info"), style: .done, target: self, action: #selector(PuanVerViewController.infoTapped))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
        //KULLANICIYA BEKLEMESİ SÖYLENECEK
        let alert = UIAlertController(title: nil, message: "Sorular Listeleniyor...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.dismiss(animated: true, completion: nil)
            self.fetchQuestions()
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sorularJson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SorularCell") as! PuanVerTableViewCell
        
        cell.shadowView.cornerRadius()
        
        //el ile gölgelendirme veriliyor
        cell.shadowView.layer.shadowColor = UIColor.gray.cgColor
        cell.shadowView.layer.shadowOpacity = 0.6
        cell.shadowView.layer.shadowOffset = CGSize.zero
        cell.shadowView.layer.shadowRadius = 5
        


        if indexPath.row % 2 == 0{
            cell.shadowView.backgroundColor = UIColor.init(displayP3Red: 64/255, green: 144/255, blue: 224/255, alpha: 1.0)
        }
        else{
            cell.shadowView.backgroundColor = UIColor.init(displayP3Red: 255/255, green: 156/255, blue: 99/255, alpha: 1.0)
        }
        
        
        cell.listeBasiLabel.text = "\(indexPath.row + 1)"
        cell.listeBasiLabel.layer.masksToBounds = true
        cell.listeBasiLabel.layer.cornerRadius = 10
        
        cell.soruLabel.text = sorularJson[indexPath.row].soru
        
        //SEÇİM YAPILACAK HÜCRENİN ARKA PLAN RENGİNİ AYARLIYORUZ.
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
        
    }
    
    func fetchQuestions(){
        
        DispatchQueue.main.async {
            
            //PHP DOSYASINA GÖNDERİLECEK URL OLUŞTURULUYOR
            var postString = base_url + "/soru/sorulari_getir.php"
            let myUrl = URL(string: postString )
            
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "GET"// Compose a query string
            
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
                        sorularJson = try decoder.decode([Soru].self, from: data)
                        
                        print(sorularJson)
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
    
    @objc func infoTapped(){
        
        
        UIView.transition(with: view, duration: 0.4, options: .transitionCrossDissolve, animations: {
            
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.tabBarController?.tabBar.isHidden = true
            self.tableView.isUserInteractionEnabled = false
            self.puanVerView.isHidden = false
            self.blurView.isHidden = false
            
        })
        
        
    }
  
    func setupButtons(){
        
        //radius ekleme
        btn1.layer.cornerRadius = 14
        btn2.layer.cornerRadius = 14
        btn3.layer.cornerRadius = 14
        btn4.layer.cornerRadius = 14
        btn5.layer.cornerRadius = 14

        //gölge ekleme
        //btn1
        btn1.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        btn1.layer.shadowOffset = CGSize(width: 3, height: 3)
        btn1.layer.shadowOpacity = 1.0
        btn1.layer.shadowRadius = 4
        btn1.layer.masksToBounds = false
        
        //btn2
        btn2.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        btn2.layer.shadowOffset = CGSize(width: 3, height: 3)
        btn2.layer.shadowOpacity = 1.0
        btn2.layer.shadowRadius = 4
        btn2.layer.masksToBounds = false
        
        btn3.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        btn3.layer.shadowOffset = CGSize(width: 3, height: 3)
        btn3.layer.shadowOpacity = 1.0
        btn3.layer.shadowRadius = 4
        btn3.layer.masksToBounds = false
        
        btn4.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        btn4.layer.shadowOffset = CGSize(width: 3, height: 3)
        btn4.layer.shadowOpacity = 1.0
        btn4.layer.shadowRadius = 4
        btn4.layer.masksToBounds = false
        
        btn5.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        btn5.layer.shadowOffset = CGSize(width: 3, height: 3)
        btn5.layer.shadowOpacity = 1.0
        btn5.layer.shadowRadius = 4
        btn5.layer.masksToBounds = false
        
        
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {

      
        UIView.transition(with: view, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.puanVerView.isHidden = true
               self.navigationController?.setNavigationBarHidden(false, animated: false)
               self.tabBarController?.tabBar.isHidden = false
               self.tableView.isUserInteractionEnabled = true
               self.view.backgroundColor = UIColor.clear
               self.blurView.isHidden = true
        })
            
           
            
        
        
        
        

        
    }
    
}
