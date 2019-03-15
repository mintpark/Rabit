//
//  HabitsDataManager.swift
//  Rabit
//
//  Created by hy on 2019. 3. 18..
//  Copyright © 2019년 hy. All rights reserved.
//

import Foundation

class Habit: NSObject {
    var title: String = ""
    var isFinished: Bool = false
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    init(title: String, isFinished: Bool, startDate: Date, endDate: Date) {
        self.title = title
        self.isFinished = isFinished
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func changeIsFinished() {
        isFinished = !isFinished
    }
}

class HabitsDataManager: NSObject {
    private let KEY = "habits"
    
    private var habits: [Habit] = []
    
    static let shared = HabitsDataManager()
    
    func get() -> [Habit]? {
        return habits.count == 0 ? nil : habits
    }
    
    func set(habit: Habit) {
        habits.append(habit)
    }
    
}
