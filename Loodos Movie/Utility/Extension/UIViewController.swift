//
//  UIViewController.swift
//  Loodos Movie
//
//  Created by Kasım on 17.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

extension UIViewController {

    func showTryAgainAlert(title: String, message: String, isCancelable: Bool, repeatAction: ((UIAlertAction) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if isCancelable {
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        let OKAction = UIAlertAction(title: "Tekrarla", style: .default, handler: repeatAction)
        alertController.addAction(OKAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
    }
}
