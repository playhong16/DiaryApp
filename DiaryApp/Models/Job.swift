//
//  Job.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

enum Job: String {
    case student = "학생"
    case it = "개발자"
    case soldier = "군인"
    case doctor = "의사"
    case teacher = "선생님"
    
    var title: String { rawValue }
}
