//
//  AvatarPickerVC.swift
//  Dev-smack
//
//  Created by Mac User on 5/6/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
/*
 Penguin by Hopkins, echidna by Dave Reno, Fish by Thengakola, Bird by Aleksandr Vector, Elephant by Peacock Dream, Whale by Jemis mali, turtle by Iconic, Fox by David, Chameloen by Visual Glow, Shark by Hopkins, Wolf by Louie Greco, Lion by Yi Chen, Coyote by Yi Chen, Elephant by Ryan Dell, Octopus by Yuliya Po, Owl by Chanut is Indistries, Butterfly by Lusine Mehrabyan, Porcupine by Yi Chen, Gorilla by Nicole Regan, chipmunk by Yi Chen, Spider by Edward Boatman, Giraffe by Maelle Chassard, Eagle by Iconic, Bug by Rachel Siao, Horse by Nestor Arellano, Cat by Alena, Kangaroo by Iconic, Frog by Iconic
 */

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // Variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    @IBAction func segmentControlChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = AvatarType.dark
        } else {
            avatarType = AvatarType.light
        }
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numOfColumns = 4
        }
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimention = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        return CGSize(width: cellDimention, height: cellDimention)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
