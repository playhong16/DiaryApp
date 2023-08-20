//
//  DataManager.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    private init() { }
    
    private var DiaryList: [Diary] = [
        Diary(title: "swift 공부하자",
              date: DateFormatter.makeDummyDate(dateStr: "2023-08-21 15:46") ?? Date(),
              emotion: Emotion.happy,
              content: "힘내자 화이팅!!!!",
              isLiked: true),
        Diary(title: "피곤쓰 하다 피곤쓰 하다 피곤쓰 하다 피곤쓰 하다",
              date: DateFormatter.makeDummyDate(dateStr: "2023-08-24 07:21") ?? Date(),
              emotion: Emotion.sad,
              content: "침대에 누워서 자자 침대에 누워서 자자 침대에 누워서 자자 침대에 누워서 자자 침대에 누워서 자자 침대에 누워서 자자",
              isLiked: false),
    ]

    func saveDiary(data: Diary) {
        DiaryList.append(data)
    }
    
    func getDiary() -> [Diary] {
        return DiaryList
    }
    
    func updateDiary(data: Diary) {
        let index = DiaryList.firstIndex { $0.id == data.id }
        if let index = index {
            DiaryList[index] = data
        }
    }
    
    func removeDiary(id: UUID) {
        let index = DiaryList.firstIndex { $0.id == id }
        if let index = index {
            DiaryList.remove(at: index)
        }
    }
}
