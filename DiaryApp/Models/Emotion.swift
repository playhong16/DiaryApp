//
//  Emotion.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

enum Emotion: String, CaseIterable {
    case happy = "기쁨"
    case angry = "화남"
    case nomal = "보통"
    case sad = "슬픔"
    case neutral = "중립"
    
    var color: UIColor {
        switch self {
        case .happy: return UIColor.systemYellow
        case .angry: return UIColor.systemRed
        case .nomal: return UIColor.link
        case .sad: return UIColor.lightGray
        }
    }
    
    var title: String { rawValue }
}
