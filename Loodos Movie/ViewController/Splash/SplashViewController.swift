//
//  SplashViewController.swift
//  Loodos Movie
//
//  Created by Kasım on 17.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        if Reachability.isConnectedToNetwork() {
            getValuesFromFRC()
        }else {
            self.showTryAgainAlert(title: "Hata", message: "Lütfen internet bağlantınızı kontrol ediniz.", isCancelable: false) { (_) in
                self.viewDidLoad()
            }
        }
    }

    func getValuesFromFRC(){
        if RCValues.shared.fetchComplete {
            updateButton()
        }

        RCValues.shared.loadingDoneCallback = updateButton
    }

    // MARK: UI Update
    func updateButton() {
        startButton.isEnabled = true
        DispatchQueue.main.async {
            self.startButton.setTitle(RCValues.shared.string(forKey: .welcomeMessage), for: .normal)
        }
    }

    // MARK: Start Button Action
    @IBAction func startAction(_ sender: UIButton) {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { timer in
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MasterViewController") else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
}
