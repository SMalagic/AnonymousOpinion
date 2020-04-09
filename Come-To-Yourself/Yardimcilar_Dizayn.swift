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
    let activityIndicatorColor: UIColor = .white
    
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
