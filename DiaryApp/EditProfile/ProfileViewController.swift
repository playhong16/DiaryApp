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
        
        nameLabelSet()
        ageGroupLabelSet()
        updateProfileFromUserDefaults()

        }
    
        
    
        private func nameLabelSet() {    // 닉네임 라벨 테두리 설정
            nameLabel.layer.borderWidth = 1.0
            nameLabel.layer.borderColor = UIColor.gray.cgColor
            nameLabel.layer.cornerRadius = 5.0
            // 닉네임 라벨 테두리 설정
        }
       
        private func ageGroupLabelSet() {    // 연령대 라벨 테두리 설정
            ageGroupLabel.layer.borderWidth = 1.0
            ageGroupLabel.layer.borderColor = UIColor.gray.cgColor
            ageGroupLabel.layer.cornerRadius = 5.0
          
        }
    
    func updateProfile(nickname: String?, image: UIImage?, ageGroup: String?) {
            if let nickname = nickname {    // 정보 업데이트
                nameLabel.text = nickname
            }
            if let image = image {
                profileImageView.image = image
            }
            if let ageGroup = ageGroup {
                ageGroupLabel.text = ageGroup
            }
        }
    
        private func updateProfileFromUserDefaults() {
            //사용자 정보 업데이트
            let defaults = UserDefaults.standard
            let editedNickname = defaults.string(forKey: "editedNickname")
            let imageData = defaults.data(forKey: "editedImage")
            let editedAgeGroup = defaults.string(forKey: "editedAgeGroup")
            
            updateProfile(nickname: editedNickname, image: UIImage(data: imageData ?? Data()), ageGroup: editedAgeGroup)
        }
}

