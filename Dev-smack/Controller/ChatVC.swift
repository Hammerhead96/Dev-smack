//
//  ChatVC.swift
//  Dev-smack
//
//  Created by Mac User on 5/2/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.


import UIKit

class ChatVC: UIViewController {
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(),
                action: #selector(SWRevealViewController.revealToggle(_:)),
                for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        if AuthService.instance.isLoggedIn {
            print("in ChatVC isLoggedIn find user")
            AuthService.instance.findUserByEmail (completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        if AuthService.instance.isLoggedIn {
            MessageService.instance.findAllChannel { (success) in
                print("in ChatVC isLoggedIn findAllChannel")
            }
        }
    }
}
