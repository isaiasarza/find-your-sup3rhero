//
//  AlertUtils.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 13/09/2022.
//

import UIKit

/*
extension UIAlertController {
    
    static func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        return alert
    }
    
    static func stopLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}
*/

protocol AlertLoaderProtocol where Self: UIViewController{
    var alertStyle: UIAlertController.Style {get}
}

extension AlertLoaderProtocol{
    
    func startLoader(message: String) -> UIAlertController{
        let alert = UIAlertController(title: nil, message: message, preferredStyle: self.alertStyle)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoader(alert: UIAlertController){
        alert.dismiss(animated: true)
    }
}
