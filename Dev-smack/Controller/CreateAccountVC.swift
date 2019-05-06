//
//  CreateAccountVC.swift
//  Dev-smack
//
//  Created by Mac User on 5/4/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    // Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    // I want me make this button go to LoginVC
    @IBAction func closePresed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    // Unwind will be called after Account Activation
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    @IBAction func createAccntPressed(_ sender: Any) {
//        guard let email = emailTxt.text , emailTxt.text != "" else { return }
//        guard let pass = passTxt.text , passTxt.text != "" else { return }
//        AuthService.instance.registerUser(email: email, password: pass)
//        { (success) in
//            if success {
//                print("registered user!")
//            }
//        }
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
    }
    
}
