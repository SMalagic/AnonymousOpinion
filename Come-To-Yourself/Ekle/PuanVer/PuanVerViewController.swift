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
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        cell.shadowView.backgroundColor = UIColor.white
        cell.shadowView.layer.shadowColor = UIColor.gray.cgColor
        cell.shadowView.layer.shadowOpacity = 0.6
        cell.shadowView.layer.shadowOffset = CGSize.zero
        cell.shadowView.layer.shadowRadius = 5
        
        cell.soruLabel.text = sorularJson[indexPath.row].soru
        
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
        

        tableView.isUserInteractionEnabled = false
        puanVerView.isHidden = false
        blurView.isHidden = false
        
        
    }
  
}
