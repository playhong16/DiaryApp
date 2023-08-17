//
//  Emotion.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

enum Emotion: String {
    case happy = "😄"
    case angry = "🤬"
    case nomal = "😀"
    case sad = "😭"
    
    var title: String { rawValue }
}
