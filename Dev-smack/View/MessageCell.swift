//
//  MessageCell.swift
//  Dev-smack
//
//  Created by Mac User on 5/10/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func configureCell (message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

}
