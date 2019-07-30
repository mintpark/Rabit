//
//  DateUtils.swift
//  Rabit
//
//  Created by Hayoung Park on 25/07/2019.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation

struct DateUtils: Codable {
    enum DayOfWeek: Int, CaseIterable, Codable {
        case Sun = 1, Mon, Tue, Wed, Thur, Fri, Sat
    }
    private let dayOfWeekString = ["", "Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
    
    func getDayOfWeek(_ date: Date) -> String {
//        let date = Date(timeIntervalSinceNow: TimeInterval(60*60*24*(index-2)))
        let components = Calendar.current.dateComponents([.weekday], from: date)
        return dayOfWeekString[components.weekday ?? 0]
    }
    
    func getDifference(with repeats: [DayOfWeek], from: Date, to: Date) -> Int {
        guard let totalDays = Calendar.current.dateComponents([.day], from: from, to: to).day else { return 0 }
        var targetDays = 0
        
        (0...totalDays).forEach { (i) in
            let day = Date(timeInterval: TimeInterval(60*60*24*(i)), since: from)
            let weekday = Calendar.current.dateComponents([.weekday], from: day).weekday ?? 0
            
            guard let validWeekDay = DayOfWeek(rawValue: weekday) else { return }
            targetDays += (repeats.contains(validWeekDay) ? 1 : 0)
        }
        
        return targetDays
    }
}
