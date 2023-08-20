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
    
    private var likedDiaryList: [Diary] = []
    
    private var diaryList: [Diary] = [
        Diary(title: "swift 공부하자",
              date: DateFormatter.makeDummyDate(dateStr: "2023-08-21 15:46") ?? Date(),
              emotion: Emotion.happy,
              content: "힘내자 화이팅!!!!",
              isLiked: false),
        Diary(title: "피곤쓰 하다 피곤쓰 하다 피곤쓰 하다 피곤쓰 하다",
              date: DateFormatter.makeDummyDate(dateStr: "2023-08-24 07:21") ?? Date(),
              emotion: Emotion.sad,
              content: "침대에 누워서 자자 침대에 누워서 자자 침대에 누워서 자자 침대에 누워서 자자 침대에 누워서 자자 침대에 누워서 자자",
              isLiked: false),
        Diary(title: "오늘도 빡코딩!!",
              date: DateFormatter.makeDummyDate(dateStr: "2023-08-21 20:35") ?? Date(),
              emotion: Emotion.happy,
              content: "빡코딩 화이팅 화이팅!!!!",
              isLiked: false),
        Diary(title: "소가 웃는소리를 세글자로 말하면?",
              date: DateFormatter.makeDummyDate(dateStr: "2023-08-23 16:21") ?? Date(),
              emotion: Emotion.happy,
              content: "우하하 우하하",
              isLiked: false),
    ]
    
    func getLikedDiary() -> [Diary] {
        return likedDiaryList
    }
    
    func saveLikedDiary(data: Diary) {
        likedDiaryList.append(data)
    }
    
    func saveDiary(data: Diary) {
        diaryList.append(data)
    }
    
    func getDiary() -> [Diary] {
        return diaryList
    }
    
    func getTodayDiaryList() -> [Diary] {
        let date = Date()
        let diaryList = DataManager.shared.getDiary()
        let filteredList = diaryList.filter {
            DateFormatter.formatDate(date: $0.date) == DateFormatter.formatDate(date: date)
        }.sorted {
            $0.date < $1.date
        }
        return filteredList
    }
    
    func updateDiary(data: Diary) {
        let index = diaryList.firstIndex { $0.id == data.id }
        if let index = index {
            diaryList[index] = data
        }
    }
    func removeLikedDiary(id: UUID){
        let index = likedDiaryList.firstIndex { $0.id == id }
        if let index = index {
            likedDiaryList.remove(at: index)
        }
    }
    
    func removeDiary(id: UUID) {
        let index = diaryList.firstIndex { $0.id == id }
        if let index = index {
            diaryList.remove(at: index)
        }
    }
}
