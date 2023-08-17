//
//  Emotion.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

enum Emotion: String {
    case happy = "😄"
    case angry = "🤬"
    case nomal = "😀"
    case sad = "😭"
    
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
