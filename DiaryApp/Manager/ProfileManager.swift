//
//  ProfileManager.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class ProfileManager {
    static let shared = ProfileManager()
    private init() { }
    
    private var profile : Profile? = Profile(nickName: "개굴개굴개구리",
    image: UIImage(named:"Mask group"), age: .twenties, job: .student)
    
    func saveProfile(data: Profile) {
        self.profile = data
    }
    
    func getProfile() -> Profile? {
        return profile
    }
    
    func updateProfile(data: Profile) {
        self.profile = data
    }
    
    /// 프로필 삭제
    func removeProfile() {
        profile = nil
    }
}
