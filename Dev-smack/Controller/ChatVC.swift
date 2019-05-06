//
//  ChatVC.swift
//  Dev-smack
//
//  Created by Mac User on 5/2/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
/*
    Penguin by Hopkins, echidna by Dave Reno, Fish by Thengakola, Bird by Aleksandr Vector, Elephant by Peacock Dream, Whale by Jemis mali, turtle by Iconic, Fox by David, Chameloen by Visual Glow, Shark by Hopkins, Wolf by Louie Greco, Lion by Yi Chen, Coyote by Yi Chen, Elephant by Ryan Dell, Octopus by Yuliya Po, Owl by Chanut is Indistries, Butterfly by Lusine Mehrabyan, Porcupine by Yi Chen, Gorilla by Nicole Regan, chipmunk by Yi Chen, Spider by Edward Boatman, Giraffe by Maelle Chassard, Eagle by Iconic, Bug by Rachel Siao, Horse by Nestor Arellano, Cat by Alena, Kangaroo by Iconic, Frog by Iconic
*/

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
        
    }
    

    

}
