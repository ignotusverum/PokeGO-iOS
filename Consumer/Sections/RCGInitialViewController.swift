//
//  RCGInitialViewController.swift
//  Consumer
//
//  Created by Vladislav Zagorodnyuk on 7/22/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import UIKit

class RCGInitialViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        RCGLoginManager.promiseLoginWithUserName(self.userNameTextField.text, password: self.passwordTextField.text).then { result-> Void in
            print(result)
        }
    }
}
