//
//  MyPageViewModel.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation
import Combine

final class MyPageViewModel {
    
    let spacing: CGFloat = 16
    let groupSpacing: CGFloat = 20
    let diaryList: CurrentValueSubject<[Diary], Never> = CurrentValueSubject([])
    var pickedDate: Date = Date()
    
    func selectDate(date: Date) {
        let diaryList = DataManager.shared.getDiary()
        let filteredList = diaryList.filter {
            DateFormatter.formatDate(date: $0.date) == DateFormatter.formatDate(date: date)
        }.sorted {
            $0.date < $1.date
        }
        self.diaryList.send(filteredList)
    }
}
