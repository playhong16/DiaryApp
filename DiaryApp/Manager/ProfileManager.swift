//
//  ProfileManager.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

final class ProfileManager {
    static let shared = ProfileManager()
    private init() { }
    
    private var profile: Profile?
    
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
