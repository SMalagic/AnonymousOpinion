//
//  Yardimcilar_Dizayn.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 8.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import PopupDialog
import StatusAlert

//BUTONLARIN ACTİVİTY İNDİCATOR ÇIKARTABİLMESİ İÇİN GEREKEN KLAS
class LoadingButton: UIButton {
    
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    @IBInspectable
    var activityIndicatorColor: UIColor = .white
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    func hideLoading() {
        self.setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
    }
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = activityIndicatorColor
        return activityIndicator
    }
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}

extension UIViewController {
    
    //TÜM ALERTLER BURAYA YÖNLENDİRİLECEK. BU ŞEKİLDE DEVAMLI ALERT YAZILMAK ZORUNDA OLMAYACAK
    func alertFunction(message: String){
        
        let title = "Uyarı Penceresi"
        let message = message
        let popup = PopupDialog(title: title, message: message)
        popup.transitionStyle = .fadeIn
        let buttonOne = CancelButton(title: "Tamam") {
            print("Tamam tuşuna basıldı.")
        }
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
        
    }
    func alertLittle(title: String, detail: String){
        
        // Creating StatusAlert instance
        let statusAlert = StatusAlert()
        statusAlert.image = UIImage(named: "Some image name")
        statusAlert.title = title
        statusAlert.message = detail
        statusAlert.canBePickedOrDismissed = true
        
        // Presenting created instance
        statusAlert.showInKeyWindow()
        
    }
    func shadowView(){
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.3
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        
      
    }
}

//tüm view'lerdeki gölgelendirmeleri içeren bir fonksiyondur
extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 5
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadowTiny(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 4
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func cornerRadius(){
        layer.cornerRadius = 12
    }
    

    
}


//TABLODA BOŞ İKEN BELİRLEDĞİİMİZ MESAJ YAZACAK
extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor(red: 31/255, green: 33/255, blue: 36/255, alpha: 1.0)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Futura", size: 35)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}








