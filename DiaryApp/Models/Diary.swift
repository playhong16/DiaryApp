//
//  Diary.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

struct Diary {
    var id: UUID = UUID()
    var title: String
    var date: Date
    var emotion : String
    var content: String
    var hashTag: String?
    var image: UIImage?
    var isLiked = false
}
