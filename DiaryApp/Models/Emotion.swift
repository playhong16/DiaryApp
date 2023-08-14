//
//  Emotion.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

enum Emotion: String {
    case happy = "기쁨"
    case angry = "화남"
    case nomal = "보통"
    case sad = "슬픔"
    
    var title: String { rawValue }
}
