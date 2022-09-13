//
//  SignOutButton.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 13/09/2022.
//

import UIKit
import FirebaseAuth
@objc protocol SignOutButtonProtocol where Self: UIViewController{
    var buttonTitle: String {get}
    @objc func onClickMessageButton()
}

extension SignOutButtonProtocol{
    func addSignOutButton(){
        self.parent!.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                title: buttonTitle,
                style:.plain,
                target: self,
                action: #selector(onClickMessageButton)
            )
        ]
    }
}
