//
//  PageViewController.swift
//  FBase
//
//  Created by Vladislav Barinov on 05.07.2020.
//  Copyright © 2020 Vladislav Barinov. All rights reserved.
//

import UIKit
import Firebase

class PageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func exitPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  let exitvc = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
                  self.present(exitvc, animated: true, completion: nil)
        } catch {
            print("error")
        }
      
    }
    

}
