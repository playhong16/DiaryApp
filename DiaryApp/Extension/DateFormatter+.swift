//
//  DateFormatter+.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

extension DateFormatter {
    static func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
    
    static func formatTime(date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH시 mm분"
        return timeFormatter.string(from: date)
    }
    
    /// yyyy/MM/dd HH:mm 형식
    static func makeDummyDate(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        if let date = dateFormatter.date(from: dateStr) {
            return date
        } else {
            print("Invalid date format")
            return nil
        }
    }
}
