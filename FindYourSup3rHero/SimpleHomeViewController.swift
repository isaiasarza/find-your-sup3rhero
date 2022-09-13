//
//  SimpleHomeViewController.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 06/09/2022.
//

import UIKit
import FirebaseAuth

class SimpleHomeViewController: UIViewController {

    @IBOutlet weak var closeSessionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func closeSessionButtonAction(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        }catch{}
    }
}
