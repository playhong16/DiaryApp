//
//  ProfileViewController.swift
//  DiaryApp
//
//  Created by Lee on 2023/08/16.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageGroupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let editedNickname = defaults.string(forKey: "editedNickname")
        let imageData = defaults.data(forKey: "editedImage")
        let editedAgeGroup = defaults.string(forKey: "editedAgeGroup")
        
        if let nickname = editedNickname {
            nameLabel.text = nickname
        }
        if let imageData = imageData, let image = UIImage(data: imageData) {
            profileImageView.image = image
        }
        if let ageGroup = editedAgeGroup {
            ageGroupLabel.text = ageGroup
            print("test\(ageGroup)")
        }
    }
    
}

