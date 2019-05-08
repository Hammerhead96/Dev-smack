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
    // Default Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }
    @IBAction func closePresed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func createAccntPressed(_ sender: Any) {
        guard let name = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        AuthService.instance.registerUser(email: email, password: pass)
        { (success) in
            if success {
                print("registered user!")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print("\(UserDataService.instance.name) \n\(UserDataService.instance.avatarName)")
                                self.performSegue(withIdentifier: UNWIND, sender: nil)  }
                        })  }   })
            }   }   }
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
    }
    
}
