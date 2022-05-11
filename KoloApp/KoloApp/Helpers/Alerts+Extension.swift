//
//  Alerts+Extension.swift
//  KoloApp
//
//  Created by Jefin on 11/05/22.
//

import UIKit

extension UIViewController {
    func showAlert() {
        let alertController = UIAlertController(title: "Network Connection", message: "Please check your network connectivity", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
}
