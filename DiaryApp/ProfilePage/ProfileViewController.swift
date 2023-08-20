//
//  ProfileViewController.swift
//  DiaryApp
//
//  Created by Lee on 2023/08/16.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var likeList: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageGroupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabelSet()
        setEditProfileButton()
        profileImageViewSet()
        likeListSet()
        ageGroupLabelSet()
        view.backgroundColor = .customBeige
        navigationController?.navigationBar.tintColor = .customBrown

    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateProfile()
    }
    
    private func updateProfile() {
        if let profile = ProfileManager.shared.getProfile() {
            updateProfile(nickname: profile.nickName, image: profile.image, ageGroup: profile.age.title)
        }
    }
    
    func updateProfile(nickname: String?, image: UIImage?, ageGroup: String?) {
        if let nickname = nickname {    // 정보 업데이트
            nameLabel.text = " " + nickname
        }
        if let image = image {
            profileImageView.image = image
        }
        if let ageGroup = ageGroup {
            ageGroupLabel.text = " " + ageGroup
        }
    }
    
    private func profileImageViewSet() {
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.customDarkBeige.cgColor
        profileImageView.layer.cornerRadius = 5
    }
    
    private func setEditProfileButton() {
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.borderColor = UIColor.customDarkBeige.cgColor
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.backgroundColor = .customDarkBeige
    }

    private func likeListSet() {
//        likeList.layer.borderWidth = 1
//        likeList.layer.borderColor = UIColor.customDarkBeige.cgColor
//        likeList.layer.cornerRadius = 8
    }
    
    private func nameLabelSet() {    // 닉네임 라벨 테두리 설정
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.customDarkBeige.cgColor
        nameLabel.layer.cornerRadius = 5
        nameLabel.textColor = .customBrown
    }
       
    private func ageGroupLabelSet() {    // 연령대 라벨 테두리 설정
        ageGroupLabel.layer.cornerRadius = 5
        ageGroupLabel.layer.borderWidth = 1
        ageGroupLabel.layer.borderColor = UIColor.customDarkBeige.cgColor
        ageGroupLabel.textColor = .customBrown
    }
}

