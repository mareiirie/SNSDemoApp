//
//  ViewController.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/01.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    private let firebaseAuthHandler = FirebaseAuthHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseAuthHandler.delegate = self
        userNameTextField.delegate = self
        mailAddressTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func didTapSignUpButton(_ sender: Any) {
        let userName = userNameTextField.text
        let mailAddress = mailAddressTextField.text
        let password = passwordTextField.text
        firebaseAuthHandler.signUp(email: mailAddress!, password: password!, name: userName!)
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        let mailAddress = mailAddressTextField.text
        let password = passwordTextField.text
        firebaseAuthHandler.signIn(email: mailAddress!, password: password!)
    }

}

extension LoginViewController: FirebaseResultDelegate {

    func didFailed(message: String) {
        self.showWarning(message: message)
    }
    
    func didSignUpSucceed(message: String) {
        self.showWarning(message: message)
    }

    func didSignInSucceed(user: User){
        self.performSegue(withIdentifier: "toHome", sender: self)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
