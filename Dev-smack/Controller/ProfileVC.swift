//
//  ProfileVC.swift
//  Dev-smack
//
//  Created by Mac User on 5/7/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    // Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    let data = UserDataService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutPressed(_ sender: Any) {
        data.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    func setupView() {
        profileImg.image = UIImage(named: data.avatarName)
        userName.text = data.name
        userEmail.text = data.email
        profileImg.backgroundColor = data.returnUIColor(components: data.avatarColor)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
