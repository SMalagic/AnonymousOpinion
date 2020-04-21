//
//  PuanVerViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 16.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import SCLAlertView
import SPAlert

class PuanVerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var puan = 0
    var indexPathRow = 0
    
    //tüm puanlar sırayla bu dizide tutulacak
    //soru sayısı değişince burası da değişmelidir
    var puanArray = [3,3,3,3,3,3]
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //geri dönüş butonu deaktif etme
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        //navigation bar gradient renkleri ayarlanır
        self.navigationController?.navigationBar.setGradientBackground(colors: [
            UIColor.red.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor
        ])
     
        
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sorularJson.count == 0{
            print(puanArray)
        }
        return sorularJson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoruCell") as! PuanVerTableViewCell
        
        //Tüm butonlara aksiyon eklemesi yapacağız
        cell.btn1.addTarget(self, action: #selector(btn1Tapped(_:)), for: .touchUpInside)
        cell.btn1.tag = indexPath.row
            cell.btn2.addTarget(self, action: #selector(btn2Tapped(_:)), for: .touchUpInside)
            cell.btn2.tag = indexPath.row
        cell.btn3.addTarget(self, action: #selector(btn3Tapped(_:)), for: .touchUpInside)
        cell.btn3.tag = indexPath.row
            cell.btn4.addTarget(self, action: #selector(btn4Tapped(_:)), for: .touchUpInside)
            cell.btn4.tag = indexPath.row
        cell.btn5.addTarget(self, action: #selector(btn5Tapped(_:)), for: .touchUpInside)
        cell.btn5.tag = indexPath.row
        
        cell.soruLabel.text = sorularJson[indexPath.row].soru
        
        
        //SEÇİM YAPILACAK HÜCRENİN ARKA PLAN RENGİNİ AYARLIYORUZ.
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        
        return cell
        
    }
    
    //CELL İÇERİSİNDE BUTONA TARGET VERİLDİ
    @objc func btn1Tapped(_ sender: UIButton){
        let buttonRow = sender.tag
        print("İndexpath : \(buttonRow) -- Buton : 1")
        
        puanArray[buttonRow] = 1
        
        sorularJson.remove(at: buttonRow)
        self.tableView.reloadData()
    }
    @objc func btn2Tapped(_ sender: UIButton){
        let buttonRow = sender.tag
        print("İndexpath : \(buttonRow) -- Buton : 2")
        
        puanArray[buttonRow] = 2
        
        sorularJson.remove(at: buttonRow)

        self.tableView.reloadData()

    }
    @objc func btn3Tapped(_ sender: UIButton){
        let buttonRow = sender.tag
        print("İndexpath : \(buttonRow) -- Buton : 3")
        
        puanArray[buttonRow] = 3

        sorularJson.remove(at: buttonRow)
        self.tableView.reloadData()

    }
    @objc func btn4Tapped(_ sender: UIButton){
        let buttonRow = sender.tag
        print("İndexpath : \(buttonRow) -- Buton : 4")
        
        puanArray[buttonRow] = 4

        sorularJson.remove(at: buttonRow)
        self.tableView.reloadData()

    }
    @objc func btn5Tapped(_ sender: UIButton){
        let buttonRow = sender.tag
        print("İndexpath : \(buttonRow) -- Buton : 5")
        
        puanArray[buttonRow] = 5

        sorularJson.remove(at: buttonRow)
        self.tableView.reloadData()

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
    
    //sağdaki buton navigationdaki
    @objc func infoTapped(){
        
        
    }
  
   
    
}
