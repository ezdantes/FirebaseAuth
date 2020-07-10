//
//  SigninViewController.swift
//  FBase
//
//  Created by Vladislav Barinov on 05.07.2020.
//  Copyright © 2020 Vladislav Barinov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SigninViewController: UIViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        
    }
    
    func cheakValid()  {
        if firstNameField.text != "",
            lastNameField.text != "",
            emailField.text != "",
            passwordField.text != "" {
            print("OK")
        } else {
            let alert = UIAlertController(title: "Не все поля заполнены", message: "Заполните все поля", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            errorLabel.isHidden = false
            errorLabel.text = String(describing: alert.message!)
        }
      
    }
    

    @IBAction func signinPressed(_ sender: UIButton) {
        cheakValid()
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
            if error != nil {
                let alert = UIAlertController(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: [
                    "firstname":self.firstNameField.text!,
                    "lastname": self.lastNameField.text!,
                    "uid": result!.user.uid,
                    
                ]) { (error) in
                    if error != nil {
                        fatalError("Error saving users in database")
                    }
                }
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let pageVC = storyboard.instantiateViewController(identifier: "PageViewController") as! PageViewController
            self.present(pageVC, animated: true, completion: nil)
            print("jump to the next screen")
        }
    }
    

}
