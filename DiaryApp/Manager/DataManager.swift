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
        Diary(title: "인생이 커피처럼 쓰다..", date: Date(), emotion: Emotion.sad.title, content: ""),
        Diary(title: "Swift는 너무 즐거워 하하", date: Date(), emotion: Emotion.happy.title, content: ""),
        Diary(title: "길가다가 한 대 맞았습니다..", date: Date(), emotion: Emotion.sad.title, content: "")
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
