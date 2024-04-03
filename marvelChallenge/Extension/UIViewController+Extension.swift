//
//  UIViewController+Extension.swift
//  marvelChallenge
//
//  Created by Mohammed Ashour on 4/3/24.
//

import UIKit

extension UIViewController {
    func showNetworkError(errorDesc:String?) {
        let alert = UIAlertController(title: "Error", message: errorDesc ?? "Unknown Error", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { act in
            print("ok")
        }))
        self.present(alert, animated: true)
    }
    
    
}
