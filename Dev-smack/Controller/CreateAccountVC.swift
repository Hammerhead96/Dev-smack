//
//  CreateAccountVC.swift
//  Dev-smack
//
//  Created by Mac User on 5/4/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    // I want me make this button go to LoginVC
    @IBAction func closePresed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    // Unwind will be called after Account Activation
    

}
