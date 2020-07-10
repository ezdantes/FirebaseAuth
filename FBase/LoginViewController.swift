//
//  LoginViewController.swift
//  FBase
//
//  Created by Vladislav Barinov on 05.07.2020.
//  Copyright © 2020 Vladislav Barinov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true

        
    }
    
    func checkLogin() {
        if emailField.text != "",
                   passwordField.text != "" {
                   print("login")
               } else {
                   let alert = UIAlertController(title: "Не все поля заполнены", message: "Заполните все поля", preferredStyle: .alert)
                              let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                              alert.addAction(okAction)
                              present(alert, animated: true, completion: nil)
               }
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        checkLogin()
        
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
            if error != nil {
                let alert = UIAlertController(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let pageVC = storyboard.instantiateViewController(identifier: "PageViewController") as! PageViewController
                self.present(pageVC, animated: true, completion: nil)
            }
        }
        
       
    }
    

}
