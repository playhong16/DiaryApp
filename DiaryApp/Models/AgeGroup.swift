//
//  AgeGroup.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

enum AgeGroup: String {
    case teenager = "10대"
    case twenties = "20대"
    case thirties = "30대"
    case forties = "40대"
    case etc = "40대 이상"
    
    var title: String { rawValue }
}
