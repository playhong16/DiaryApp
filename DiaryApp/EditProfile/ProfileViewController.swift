//
//  ProfileViewController.swift
//  DiaryApp
//
//  Created by Lee on 2023/08/16.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var pIV: UIImageView!
    
    @IBOutlet weak var ePB: UIButton!
    @IBOutlet weak var likeList: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var ageGroupLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateProfile()
        jobLabelSet()
        nameLabelSet()
        ePBSet()
        pIVSet()
        likeListSet()
        ageGroupLabelSet()
        view.backgroundColor = .customBeige
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
    
    private func pIVSet() {
        pIV.layer.borderWidth = 1
        pIV.layer.borderColor = UIColor.customDarkBeige.cgColor
        pIV.layer.cornerRadius = 8
    }
    
    private func ePBSet() {
        ePB.layer.borderWidth = 1
        ePB.layer.borderColor = UIColor.customDarkBeige.cgColor
        ePB.layer.cornerRadius = 8
    }

    private func likeListSet() {
        likeList.layer.borderWidth = 1
        likeList.layer.borderColor = UIColor.customDarkBeige.cgColor
        likeList.layer.cornerRadius = 8
    }
    
    
    private func jobLabelSet() {
        jobLabel.layer.borderWidth = 1
        jobLabel.layer.borderColor = UIColor.customDarkBeige.cgColor
        jobLabel.layer.cornerRadius = 8
    }
    
    private func nameLabelSet() {    // 닉네임 라벨 테두리 설정
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.customDarkBeige.cgColor
        nameLabel.layer.cornerRadius = 8
    }
       
    private func ageGroupLabelSet() {    // 연령대 라벨 테두리 설정
        ageGroupLabel.layer.cornerRadius = 8
        ageGroupLabel.layer.borderWidth = 1
        ageGroupLabel.layer.borderColor = UIColor.customDarkBeige.cgColor
    }
    
 
}

