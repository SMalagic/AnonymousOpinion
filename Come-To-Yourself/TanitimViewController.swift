//
//  TanitimViewController.swift
//  Come-To-Yourself
//
//  Created by Serkan Mehmet Malagiç on 14.04.2020.
//  Copyright © 2020 Serkan Mehmet Malagiç. All rights reserved.
//

import UIKit
import SwiftGifOrigin
import AVFoundation


class TanitimViewController: UIViewController {
    
    @IBOutlet weak var oynatButton: LoadingButton!
    var player: AVAudioPlayer?
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jeremyGif = UIImage.gif(name: "apple")
        imgView.image = jeremyGif
        
        
    }
    
    
    @IBAction func oynatButtonTapped(_ sender: Any) {
        
        view.isUserInteractionEnabled = false
        oynatButton.showLoading()
        playSound()
        
        //mp3 ses kaydının uzunluu ile aynı olmalıdır
        //bitiğinde diğer sayfaya yönlendirilecektir
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.view.isUserInteractionEnabled = true
            self.performSegue(withIdentifier: "toGirisYapSegue", sender: nil)
            self.player?.stop()
        }
        
    }
    
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "ciftetelli", withExtension: "mp3") else {
            print("url not found")
            return
        }
        
        do {
            /// this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /// change fileTypeHint according to the type of your audio file (you can omit this)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
            player!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
}
