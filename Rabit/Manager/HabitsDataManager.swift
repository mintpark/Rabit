//
//  HabitsDataManager.swift
//  Rabit
//
//  Created by hy on 2019. 3. 18..
//  Copyright © 2019년 hy. All rights reserved.
//

import Foundation

class Habit: Codable {
    var title: String = ""
    var isFinished: Bool = false
    var startDate: Date = Date()
    var endDate: Date = Date()
    var repeats: [DateUtils.DayOfWeek] = []
    
    init(title: String, isFinished: Bool, startDate: Date, endDate: Date) {
        self.title = title
        self.isFinished = isFinished
        self.startDate = startDate
        self.endDate = endDate
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case isFinished
        case startDate
        case endDate
        case repeats
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(isFinished, forKey: .isFinished)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(repeats, forKey: .repeats)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        isFinished = try values.decode(Bool.self, forKey: .isFinished)
        startDate = try values.decode(Date.self, forKey: .startDate)
        startDate = try values.decode(Date.self, forKey: .startDate)
        repeats = try values.decode([DateUtils.DayOfWeek].self, forKey: .repeats)
    }
    
    func changeIsFinished() {
        isFinished = !isFinished
    }
}

class HabitsDataManager: NSObject {
    static let KEY_HABITS = "KEY_HABITS"
    
    static let shared = HabitsDataManager()
    
    private(set) var habits: [Habit] {
        get {
            guard let data = UserDefaults.standard.object(forKey: HabitsDataManager.KEY_HABITS) as? Data,
                let habits = try? JSONDecoder().decode([Habit].self, from: data) else { return [] }
            return habits
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: HabitsDataManager.KEY_HABITS)
            UserDefaults.standard.synchronize()
        }
    }
    
    func set(habit: Habit) {
        habits.append(habit)
    }
    
    func remove(at indexPath: IndexPath) {
        habits.remove(at: indexPath.row)
    }
}
