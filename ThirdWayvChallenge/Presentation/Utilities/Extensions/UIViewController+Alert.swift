//
//  UIViewController+Alert.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
