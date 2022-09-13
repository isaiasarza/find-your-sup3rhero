//
//  AuthViewController.swift
//  FindYourSup3rHero
//
//  Created by Isaias Arza on 06/09/2022.
//

import UIKit
import FirebaseAuth
class AuthViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkUserIsLoggedIn()
    }
                                                    

    @IBAction func signInButtonAction(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text{
            let loader = self.startLoader(message: "Ingresando...")
            Auth.auth().signIn(withEmail: email, password: password){
                (result, error) in
                if let result = result, error == nil{
                    self.stopLoader(alert: loader)
                    self.userDefaults.set(true, forKey: ConfigVariables.loggedInKey)
                    self.goToHome()
                }else{
                    self.stopLoader(alert: loader)
                    self.handleSignInError(error: error)
                }
            }
        }
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text{
            let loader = self.startLoader(message: "Creando cuenta...")
            Auth.auth().createUser(withEmail: email, password: password){ [self]
                (result, error) in
                
                if let result = result, error == nil{
                    self.stopLoader(alert: loader)
                    self.userDefaults.set(true, forKey: ConfigVariables.loggedInKey)
                    self.goToHome()
                }else{
                    self.stopLoader(alert: loader)
                    self.handleSignUpError(error: error)
                }
            }
        }
    }
    
    /**
        Redirigue al home
     */
    private func goToHome(){
     
       //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
       //let tabBarController = storyBoard.instantiateViewController(withIdentifier: "Home") as! Home
       self.performSegue(withIdentifier: "goHome", sender: self)
        // self.navigationController?.pushViewController(Home(), animated: true)
        // let vc = Home(nibName: nil, bundle: nil)

    }
    
    private func checkUserIsLoggedIn(){
        if(self.userDefaults.bool(forKey: ConfigVariables.loggedInKey)){
            self.goToHome()
        }
    }
    
    private func showErrorAlert(errorMessage: String){
        var dialogMessage = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (actin) in
                   dialogMessage.dismiss(animated: true, completion: nil)
               }))
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    private func handleSignInError(error: Error?){
        if let errCode = AuthErrorCode.Code(rawValue: error!._code) {
            var errorMessage: String?
            switch errCode {
                case .invalidEmail:
                errorMessage = SignInErrorsEnum.invalidEmail.rawValue
                case .wrongPassword:
                errorMessage = SignInErrorsEnum.wrongPassword.rawValue
                default:
                errorMessage = SignInErrorsEnum.defaultError.rawValue
            }
            self.showErrorAlert(errorMessage: errorMessage!)
        }
    }
    
    private func handleSignUpError(error: Error?){
        var errorMessage: String?
        if let errCode = AuthErrorCode.Code(rawValue: error!._code) {
            
            switch errCode {
            case .invalidEmail:
                errorMessage = SignUpErrorsEnum.invalidEmail.rawValue
            case .emailAlreadyInUse:
                errorMessage = SignUpErrorsEnum.emailAlreadyInUse.rawValue
            default:
                errorMessage = SignUpErrorsEnum.defaultError.rawValue
            }
        }
        self.showErrorAlert(errorMessage: errorMessage!)
    }
    
}

extension AuthViewController: AlertLoaderProtocol{
    var alertStyle: UIAlertController.Style {
        get {
            .alert
        }
    }
}

