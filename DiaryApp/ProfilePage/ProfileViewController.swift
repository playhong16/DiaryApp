//
//  ProfileViewController.swift
//  DiaryApp
//
//  Created by Lee on 2023/08/16.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nicknameTitleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var likeList: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageGroupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabelSet()
        setEditProfileButton()
        ageGroupLabelSet()
        view.backgroundColor = .customBeige
        navigationController?.navigationBar.tintColor = .customBrown
        configureLikeList()

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
            nameLabel.text = nickname
        }
        if let image = image {
            profileImageView.image = image
        }
        if let ageGroup = ageGroup {
            ageGroupLabel.text = ageGroup
        }
    }
    private func setEditProfileButton() {
        profileImageView.layer.cornerRadius = 8
        
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.borderColor = UIColor.customDarkBeige.cgColor
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.backgroundColor = .customDarkBeige
    }
    
    private func configureLikeList() {
        likeList.layer.cornerRadius = 5
        likeList.layer.borderWidth = 1
        likeList.layer.borderColor = UIColor.customDarkBeige.cgColor
        likeList.setTitleColor(.customDarkBeige, for: .normal)
    }
    
    private func nameLabelSet() {    // 닉네임 라벨 테두리 설정
        nicknameTitleLabel.textColor = .customBrown
        nameLabel.textColor = .customBrown
    }
       
    private func ageGroupLabelSet() {    // 연령대 라벨 테두리 설정
        ageGroupLabel.textColor = .customBrown
    }
}

